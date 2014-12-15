//
//  FoodViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/20/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "FoodViewController.h"
#import "PetFood.h"
#import "TableViewCell.h"
#import "TableViewCellExtra.h"

@interface FoodViewController ()
@property (strong, nonatomic) IBOutlet UITableView *foodTableView;

@property (strong, nonatomic) NSMutableArray *foodArray;

@end

@implementation FoodViewController

#pragma mark - Ciclo de Vida

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initFoodArray];
    
    [self.foodTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TableViewCell"];
    [self.foodTableView registerNib:[UINib nibWithNibName:@"TableViewCellExtra" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TableViewCellExtra"];
    [self.foodTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTitle:@"Food"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setTitle:@"---"];
}

#pragma mark - Metodos Privados

- (void) initFoodArray
{
    PetFood* food1 = [[PetFood alloc] initWithFood:@"Cake" andImagePath:@"comida_0" andEnergyValue:10];
    PetFood* food2 = [[PetFood alloc] initWithFood:@"Pie" andImagePath:@"comida_1" andEnergyValue:20];
    PetFood* food3 = [[PetFood alloc] initWithFood:@"Ice Cream" andImagePath:@"comida_2" andEnergyValue:30];
    PetFood* food4 = [[PetFood alloc] initWithFood:@"Chicken" andImagePath:@"comida_3" andEnergyValue:40];
    PetFood* food5 = [[PetFood alloc] initWithFood:@"Burger" andImagePath:@"comida_4" andEnergyValue:50];
    PetFood* food6 = [[PetFood alloc] initWithFood:@"Fish" andImagePath:@"comida_5" andEnergyValue:60];
    PetFood* food7 = [[PetFood alloc] initWithFood:@"Fruit" andImagePath:@"comida_6" andEnergyValue:70];
    PetFood* food8 = [[PetFood alloc] initWithFood:@"Hot Dog" andImagePath:@"comida_7" andEnergyValue:80];
    PetFood* food9 = [[PetFood alloc] initWithFood:@"Meat" andImagePath:@"comida_8" andEnergyValue:90];
    
    self.foodArray = [NSMutableArray arrayWithArray:@[food1, food2, food3, food4, food5, food6, food7, food8, food9]];
}

#pragma mark - TableView delegate.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foodArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* simpleTableIdentifier;
    //if(indexPath.row % 2)
    //{
        simpleTableIdentifier = @"TableViewCellExtra";
    //}
    //else
    //{
    //    simpleTableIdentifier = @"TableViewCell";
    //}
    
    TableViewCell* newCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    [newCell.myImageView setImage:[UIImage imageNamed:((PetFood*)self.foodArray[indexPath.row]).imagePath]];
    [newCell.myLblName setText:[NSString stringWithFormat: @"%@ (%d)", ((PetFood*)self.foodArray[indexPath.row]).foodName, ((PetFood*)self.foodArray[indexPath.row]).foodEnergyValue]];
    return newCell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Food";
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.foodDelegate respondsToSelector:@selector(didSelectFood:)])
    {
        [self.foodDelegate didSelectFood:(PetFood*)self.foodArray[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
