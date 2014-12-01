//
//  PetListViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/29/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetListViewController.h"
#import "NetworkAccessObject.h"
#import "PetListCell.h"
#import "Pet.h"

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
    
    [self.petRankingList registerNib:[UINib nibWithNibName:@"PetListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PetListCell"];
    [self.petRankingList reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    return self.petArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PetListCell* newCell = [tableView dequeueReusableCellWithIdentifier:@"PetListCell"];
    
    if(!newCell)
    {
        newCell = [[PetListCell alloc] init];
    }

    // Iniciamos los datos de la celda
    Pet* pet = (Pet*)[self.petArraySorted objectAtIndex:indexPath.row];
    
    [newCell.petImageView setImage:[UIImage imageNamed:pet.petImageName]];
    [newCell.petLevelLabel setText:[NSString stringWithFormat:@"%d", pet.petLevel]];
    [newCell.petNameLabel setText:pet.petName];
    
    if([pet.userID isEqualToString:CODE_IDENTIFIER])
    {
        [newCell setBackgroundColor:[UIColor greenColor]];
    }
    else
    {
        [newCell setBackgroundColor:[UIColor colorWithRed:100 green:0 blue:0 alpha:0.2]];
    }
    
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
            NSString* name = [dic objectForKey:@"name"];
            int level = ((NSNumber*)[dic objectForKey:@"level"]).intValue;
            PetType type = ((NSNumber*)[dic objectForKey:@"pet_type"]).intValue;
            NSString* userId = [dic objectForKey:@"code"];
            
            Pet* newPet = [[Pet alloc] initWithType:type petName:name level:level andUserID:userId];
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

@end
