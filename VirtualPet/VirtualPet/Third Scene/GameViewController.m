//
//  GameViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "GameViewController.h"
#import "ImagesLoader.h"

float const eatAnimationTime = 0.5f;
int const eatAnimationIterations = 4;

@interface GameViewController ()

@property (strong, nonatomic) Pet *myPet;
@property (nonatomic) PetImageTag imageTag;
@property (nonatomic, strong) PetFood* myFood;
@property (nonatomic) CGPoint imageViewFoodPosition;

@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *petEnergyBar;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFood;
@property (strong, nonatomic) IBOutlet UIView *mouthFrame;

@property (strong, nonatomic) ImagesLoader* imgLoader;

@end

@implementation GameViewController

#pragma mark - Constructor

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPet:(Pet *)pet andImageTag:(PetImageTag)tag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.myPet = pet;
        self.imageTag = tag;
    }
    
    return self;
}

#pragma mark - Ciclo de Vida

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblPetName setText:self.myPet.petName];
    
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
    
    [self setTitle:[NSString stringWithFormat:@"%@", self.myPet.petName]];
    
    self.imageViewFoodPosition = CGPointMake(self.imgViewFood.frame.origin.x, self.imgViewFood.frame.origin.y);
    
    [self.mouthFrame setAlpha:0];
    
    self.imgLoader = [[ImagesLoader alloc] init];
    [self.imgLoader loadPetComiendoArrayWithTag:self.imageTag];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:[NSString stringWithFormat:@"%@", self.myPet.petName]];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self setTitle:@"---"];
}

- (void) viewDidDisappear:(BOOL)animated
{
    //self.imageViewFoodPosition = CGPointMake(246, 427);
    [self.imgViewFood setCenter:self.imageViewFoodPosition];
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

- (IBAction)handleTap:(UITapGestureRecognizer*)sender
{
    if(self.myFood)
    {
        CGPoint tapPoint = [sender locationInView:self.view];
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
            
            
            [self.imgViewFood setCenter:tapPoint];
         }completion:^(BOOL finished){
             if(finished)
             {
                 if(CGRectContainsPoint([self.mouthFrame frame], tapPoint))
                 {
                     self.imgViewFood.image = nil;
                     [self animateEatingPet];
                     NSLog(@"Morfando como un Campeon");
                 }
             }
             
         }];
    }
}

-(void) animateEatingPet
{
    NSArray *img = @[[UIImage imageNamed:self.imgLoader.imgPetComiendo[0]],
                     [UIImage imageNamed:self.imgLoader.imgPetComiendo[1]],
                     [UIImage imageNamed:self.imgLoader.imgPetComiendo[2]],
                     [UIImage imageNamed:self.imgLoader.imgPetComiendo[3]]];
    [self.petImageView setAnimationImages:img];
    [self.petImageView setAnimationDuration:eatAnimationTime];
    [self.petImageView setAnimationRepeatCount:eatAnimationIterations];
    [self.petImageView startAnimating];
    [self updatePetEnergyInTime];
}

-(void) updatePetEnergyInTime
{
    [UIView animateWithDuration:eatAnimationTime*eatAnimationIterations delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        [self.petEnergyBar setProgress:1 animated:YES];
    } completion:^(BOOL finished){
    
    }];
}

#pragma mark - Food Delegate Metodos

- (void) didSelectFood:(PetFood *)food
{
    self.myFood = food;
    [self.imgViewFood setImage:[UIImage imageNamed:self.myFood.imagePath]];
}

@end
