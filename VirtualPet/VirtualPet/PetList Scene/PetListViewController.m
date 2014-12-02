//
//  PetListViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/29/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetListViewController.h"
#import "NetworkAccessObject.h"
#import "Pet.h"
#import "MapViewController.h"

@interface PetListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *petRankingList;
@property (strong, nonatomic) NSMutableArray* petArray;
@property (strong, nonatomic) NSArray* petArraySorted;

@property (strong, nonatomic) NetworkAccessObject* daoObject;

@end

@implementation PetListViewController

//****************************************************
// Ciclo de Vida
//****************************************************

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.daoObject = [[NetworkAccessObject alloc] init];
    self.petArray = [[NSMutableArray alloc] init];
    
     [self.daoObject doGETPetList:[self getSuccess]];
    
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
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTitle:@"---"];
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
    return self.petArray.count;
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
    Pet* pet = (Pet*)[self.petArraySorted objectAtIndex:indexPath.row];
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
        
        NSArray* responseArray = (NSArray*)responseObject;
        
        for (NSDictionary* dic in responseArray) {
            Pet* newPet = [[Pet alloc] initWithDictionary:dic];
            [weakerSelf.petArray addObject:newPet];
        }
        [self sortArray];
        [weakerSelf.petRankingList reloadData];
    };
}

//****************************************************
// Ordenar Array
//****************************************************

- (void) sortArray
{
    self.petArraySorted = [self.petArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSNumber* level1 = [NSNumber numberWithInt:((Pet*)a).petLevel];
        NSNumber* level2 = [NSNumber numberWithInt:((Pet*)b).petLevel];
        
        return [level2 compare: level1];
    }];
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
    [self goToMapWithPetArray:self.petArray];
}

- (void) goToMapWithPetArray: (NSArray*) petArray
{
    MapViewController* mapView = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle] andPetArray:self.petArray];
    [self.navigationController pushViewController:mapView animated:YES];
}

@end
