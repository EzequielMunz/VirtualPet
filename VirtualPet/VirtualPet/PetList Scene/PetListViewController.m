//
//  PetListViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/29/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetListViewController.h"
#import "NetworkAccessObject.h"
#import "NSTimer+TimerWithAutoInvalidate.h"
#import "Pet.h"
#import "MapViewController.h"
#import "PetRanking.h"

@interface PetListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *petRankingList;

@property (strong, nonatomic) PetRanking* petRanking;

@property (strong, nonatomic) NetworkAccessObject* daoObject;

@property (strong, nonatomic) NSTimer* timer;

@end

@implementation PetListViewController

//****************************************************
// Ciclo de Vida
//****************************************************

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.daoObject = [[NetworkAccessObject alloc] init];
    self.petRanking = [[PetRanking alloc] init];
    
    [self.petRankingList registerNib:[UINib nibWithNibName:@"PetListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PetListCell"];
    [self.petRankingList reloadData];
    
    // Boton en la navigation
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(loadFullMap) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"map-icon"] forState:UIControlStateNormal];
    UIBarButtonItem* mailButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = mailButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTitle:@"Ranking"];
    
    [self.petRanking fetchPetRankingData];
    [self.petRankingList reloadData];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(getDataFromServer) userInfo:nil repeats:NO];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTitle:@"---"];
    
    [self.timer autoInvalidate];
}

- (void) getDataFromServer
{
    [self.daoObject doGETPetList:[self getSuccess]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//****************************************************
// Data Source
//****************************************************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.petRanking.petRankingArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PetListCell* newCell = [tableView dequeueReusableCellWithIdentifier:@"PetListCell"];
    
    if(!newCell)
    {
        newCell = [[PetListCell alloc] init];
    }
    [newCell setDelegate:self];

    // Iniciamos los datos de la celda
    Pet* pet = (Pet*)[self.petRanking.petRankingSortedArray objectAtIndex:indexPath.row];
    [newCell setPet:pet];
    
    return newCell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Pet World Ranking                            Lvl";
}

//****************************************************
// Success Block para Actualizar Vista
//****************************************************

- (Success) getSuccess
{
    __weak typeof(self) weakerSelf = self;
    
    return ^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        
        [weakerSelf.petRanking deletePetRankingData];
        
        NSArray* responseArray = (NSArray*)responseObject;
        [weakerSelf.petRanking.petRankingArray removeAllObjects];
        
        for (NSDictionary* dic in responseArray) {
            Pet* newPet = [[Pet alloc] initWithDictionary:dic];
            [weakerSelf.petRanking.petRankingArray addObject:newPet];
        }
        [weakerSelf.petRanking sortArray];
        [weakerSelf.petRankingList reloadData];
        [weakerSelf.petRanking insertPetRankingData];
    };
}


//****************************************************
// Map Delegate
//****************************************************

- (void) goToMapWithLocation:(Pet*) pet
{
    MapViewController* mapView = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle] andPet:pet];
    [self.navigationController pushViewController:mapView animated:YES];
}

- (void) loadFullMap
{
    [self goToMapWithPetArray:self.petRanking.petRankingArray];
}

- (void) goToMapWithPetArray: (NSArray*) petArray
{
    MapViewController* mapView = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle] andPetArray:self.petRanking.petRankingArray];
    [self.navigationController pushViewController:mapView animated:YES];
}

- (void) dealloc {
    [self.daoObject cancelCurrentTask];
}

@end
