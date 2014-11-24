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

NSString* const MAIL_BODY_MESSAGE = @"Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App <Nombre_de_la_app> para comerme todo y está genial. Bajatela YA!!   Saludos!";
NSString* const MAIL_SUBJECT = @"Que app copada";

@interface GameViewController ()

@property (nonatomic) PetImageTag imageTag;
@property (nonatomic, strong) PetFood* myFood;
@property (nonatomic) CGPoint imageViewFoodPosition;

@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *petEnergyBar;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFood;
@property (strong, nonatomic) IBOutlet UIView *mouthFrame;
@property (strong, nonatomic) IBOutlet UIButton *btnExcercise;

@property (strong, nonatomic) NSTimer* energyTimer;

@property (nonatomic, strong) MFMailComposeViewController* myMailView;

@end

@implementation GameViewController

#pragma mark - Constructor

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImageTag:(PetImageTag)tag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.imageTag = tag;
    }
    
    return self;
}

#pragma mark - Ciclo de Vida

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblPetName setText:[Pet sharedInstance].petName];
    [self.petImageView setImage:[UIImage imageNamed:[Pet sharedInstance].petImageName]];

    [self setTitle:[NSString stringWithFormat:@"%@", [Pet sharedInstance].petName]];
    
    self.imageViewFoodPosition = CGPointMake(self.imgViewFood.frame.origin.x, self.imgViewFood.frame.origin.y);
    
    [self.mouthFrame setAlpha:0];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(sendEMail) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
    UIBarButtonItem* mailButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = mailButton;
    
    
    // Cargamos las imagenes en el loader
    [[ImagesLoader sharedInstance] loadPetComiendoArrayWithTag:self.imageTag];
    
    // Inicializar la energia en la progress bar.
    [self.petEnergyBar setProgress:1];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:[NSString stringWithFormat:@"%@", [Pet sharedInstance].petName]];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self setTitle:@"---"];
    
    // Invalidamos el Timer
    if(self.energyTimer && [self.energyTimer isValid])
    {
        [self.energyTimer invalidate];
        self.energyTimer = nil;
    }
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

- (IBAction)btnDoExcerciseClicked:(id)sender {
    [self animateExcercisingPet];
    
    NSString* btnText = ([Pet sharedInstance].doingExcercise ? @"Stop" : @"Do Excercise");
    [self.btnExcercise setTitle:btnText forState:UIControlStateNormal];
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
    NSArray *img = @[[UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[0]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[1]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[2]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[3]]];
    [self.petImageView setAnimationImages:img];
    [self.petImageView setAnimationDuration:eatAnimationTime];
    [self.petImageView setAnimationRepeatCount:eatAnimationIterations];
    [self.petImageView startAnimating];
    [[Pet sharedInstance] doEat];
}

-(void) animateExcercisingPet
{
    NSArray *img = @[[UIImage imageNamed:[ImagesLoader sharedInstance].imgPetEjercicio[0]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetEjercicio[1]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetEjercicio[2]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetEjercicio[3]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetEjercicio[4]]];
    
    [self.petImageView setAnimationImages:img];
    [self.petImageView setAnimationDuration:eatAnimationTime];
    [self.petImageView setAnimationRepeatCount:0];
    
    if([Pet sharedInstance].doingExcercise)
    {
        [self.petImageView stopAnimating];
        
        // Invalidamos el Timer
        if(self.energyTimer && [self.energyTimer isValid])
        {
            [self.energyTimer invalidate];
            self.energyTimer = nil;
        }
        [Pet sharedInstance].doingExcercise = NO;
    }
    else
    {
        [self.petImageView startAnimating];
        self.energyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateEnergyByExcercise) userInfo:nil repeats:YES];
        [Pet sharedInstance].doingExcercise = YES;
    }
}

#pragma mark - Update Energy

- (void) updateEnergyByExcercise
{
    [[Pet sharedInstance] doExcercise];
}


#pragma mark - Food Delegate Metodos

- (void) didSelectFood:(PetFood *)food
{
    self.myFood = food;
    [self.imgViewFood setImage:[UIImage imageNamed:self.myFood.imagePath]];
}

#pragma  mark - Pet Delegate Methods

- (void) updateEnergyBarByExcercise:(int)value
{
    float barValue = value;
    barValue = barValue/100;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        [self.petEnergyBar setProgress:barValue animated:YES];
    } completion:^(BOOL finished){
        
    }];
    if(value == 0)
    {
        [self.petImageView stopAnimating];
        [self.btnExcercise setEnabled:NO];
        [self.btnExcercise setTitle:@"Do Excercise" forState:UIControlStateNormal];
        [Pet sharedInstance].doingExcercise = NO;
        // Invalidamos el Timer
        if(self.energyTimer && [self.energyTimer isValid])
        {
            [self.energyTimer invalidate];
            self.energyTimer = nil;
        }
    }
}

- (void) updateEnergyBarByEating:(int)value
{
    [UIView animateWithDuration:eatAnimationTime*eatAnimationIterations delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        [self.petEnergyBar setProgress:value/100 animated:YES];
    } completion:^(BOOL finished){
        
    }];
    [self.btnExcercise setEnabled:YES];
}

#pragma mark - E-Mail Methods
//********************************************
// Metodo para abrir la pantalla de MAIL
//********************************************
- (void) sendEMail
{
    NSString* mailBody = [NSString stringWithFormat:MAIL_BODY_MESSAGE, [Pet sharedInstance].petName];
    NSString* mailSubject = MAIL_SUBJECT;
    self.myMailView = [[MFMailComposeViewController alloc] init];
    self.myMailView.mailComposeDelegate = self;
    [self.myMailView setSubject:mailSubject];
    [self.myMailView setMessageBody:mailBody isHTML:NO];
    [self.myMailView setTitle:@"EMAIL"];
    [self presentViewController:self.myMailView animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Messagge sent succesfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        break;
        case MFMailComposeResultCancelled:
            [[[UIAlertView alloc] initWithTitle:@"Cancelled" message:@"Mail has been cancelled" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        break;
        case MFMailComposeResultFailed:
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error sending the E-Mail" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        break;
        case MFMailComposeResultSaved:
            [[[UIAlertView alloc] initWithTitle:@"Save" message:@"Messagge saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
