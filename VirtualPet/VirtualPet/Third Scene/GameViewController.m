//
//  GameViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()

@property (strong, nonatomic) NSString *myPetName;
@property (nonatomic) PetImageTag imageTag;
@property (nonatomic, strong) PetFood* myFood;

@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *petEnergyBar;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFood;

@end

@implementation GameViewController

#pragma mark - Constructor

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetName:(NSString *)name andImageTag:(PetImageTag)tag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.myPetName = name;
        self.imageTag = tag;
    }
    
    return self;
}

#pragma mark - Ciclo de Vida

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblPetName setText:self.myPetName];
    
    switch (self.imageTag) {
        case PET_CIERVO:
            [self.petImageView setImage:[UIImage imageNamed:@"ciervo_comiendo_1"]];
            break;
        case PET_GATO:
            [self.petImageView setImage:[UIImage imageNamed:@"gato_comiendo_1"]];
            break;
        case PET_JIRAFA:
            [self.petImageView setImage:[UIImage imageNamed:@"jirafa_comiendo_1"]];
            break;
        case PET_LEON:
            [self.petImageView setImage:[UIImage imageNamed:@"leon_comiendo_1"]];
            break;
            
        default:
            break;
    }
    
    [self setTitle:[NSString stringWithFormat:@"%@", self.myPetName]];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:[NSString stringWithFormat:@"%@", self.myPetName]];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self setTitle:@"---"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Metodos Privados

- (IBAction)btnFoodClicked:(id)sender
{
    FoodViewController *myFoodView = [[FoodViewController alloc] initWithNibName:@"FoodViewController" bundle:[NSBundle mainBundle]];
    [myFoodView setFoodDelegate:self];
    [self.navigationController pushViewController:myFoodView animated:YES];
}

-(void) updatePetEnergy
{
    
}

#pragma mark - Food Delegate Metodos

- (void) didSelectFood:(PetFood *)food
{
    self.myFood = food;
    [self.imgViewFood setImage:[UIImage imageNamed:self.myFood.imagePath]];
}

@end
