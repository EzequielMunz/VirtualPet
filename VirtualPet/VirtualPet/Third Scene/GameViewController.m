//
//  GameViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "GameViewController.h"
#import "ImagesLoader.h"
#import "NSTimer+TimerWithAutoInvalidate.h"
#import "NetworkAccessObject.h"
#import "NotificationManager.h"

float const eatAnimationTime = 0.5f;
float const exhaustAnimationTime = 1.2f;
int const eatAnimationIterations = 4;


NSString* const MAIL_BODY_MESSAGE = @"Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App <Nombre_de_la_app> para comerme todo y está genial. Bajatela YA!!   Saludos!";
NSString* const MAIL_SUBJECT = @"Que app copada";

@interface GameViewController ()

@property (nonatomic) PetType imageTag;
@property (nonatomic, strong) PetFood* myFood;
@property (nonatomic) CGPoint imageViewFoodPosition;

@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *petEnergyBar;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFood;
@property (strong, nonatomic) IBOutlet UIView *mouthFrame;
@property (strong, nonatomic) IBOutlet UIButton *btnExcercise;
@property (strong, nonatomic) IBOutlet UIProgressView *petExpProgressBar;
@property (strong, nonatomic) IBOutlet UILabel *lblExperience;

@property (strong, nonatomic) NSTimer* energyTimer;

@property (nonatomic, strong) MFMailComposeViewController* myMailView;
@property (nonatomic, strong) NetworkAccessObject* daoObject;

@end

@implementation GameViewController

#pragma mark - Constructor

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImageTag:(PetType)tag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.imageTag = tag;
    }
    
    return self;
}

#pragma mark - Ciclo de Vida

//*************************************************************
// Ciclo de Vida
//*************************************************************

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblPetName setText:[NSString stringWithFormat:@"%@ Lvl: %d", [Pet sharedInstance].petName, [Pet sharedInstance].petLevel]];
    [self.petImageView setImage:[UIImage imageNamed:[Pet sharedInstance].petImageName]];

    [self setTitle: [Pet sharedInstance].petName];
    
    self.imageViewFoodPosition = CGPointMake(self.imgViewFood.frame.origin.x, self.imgViewFood.frame.origin.y);
    
    [self.mouthFrame setAlpha:0];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(sendEMail) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
    UIBarButtonItem* mailButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = mailButton;
    
    // Personalizacion de progress bar
     [self.petEnergyBar setTransform:CGAffineTransformMakeScale(1.0, 7.0)];
    
    // Cargamos las imagenes en el loader
    [[ImagesLoader sharedInstance] loadPetComiendoArrayWithTag:self.imageTag];
    
    // Inicializar la energia en la progress bar.
    [self.petEnergyBar setProgress:1];
    
    [self.lblExperience setText:[NSString stringWithFormat:@"%d / %d", [[Pet sharedInstance] getActualExp], [[Pet sharedInstance] getNeededExp]]];
    float actualExp = [[Pet sharedInstance] getActualExp];
    float barValue = actualExp/[[Pet sharedInstance] getNeededExp];
    [self.petExpProgressBar setProgress:barValue];
    
    // Instanciamos el DAO
    self.daoObject = [[NetworkAccessObject alloc] init];

}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:@"Home"];
    
    // Se suscribe la vista para las notificaciones
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePetEnergyInProgressBar:) name:EVENT_UPDATE_ENERGY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePetExhaust) name:EVENT_SET_EXHAUST object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLevelUp:) name:EVENT_LEVEL_UP object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateExperience) name:EVENT_UPDATE_EXPERIENCE object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:EVENT_RELOAD_DATA object:nil];
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self setTitle:@"---"];
    
    // Invalidamos el Timer
    [self.energyTimer autoInvalidate];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.petImageView stopAnimating];
    [self.btnExcercise setTitle:@"Do Excercise" forState:UIControlStateNormal];
    [Pet sharedInstance].doingExcercise = false;
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

//*************************************************************
// Eventos de Touch
//*************************************************************
- (IBAction)btnLoadDataClicked:(id)sender
{
    [self.daoObject doGETPetInfo:[self getSuccess]];
}

- (void) reloadData: (NSNotification*) notif
{
    [self.lblPetName setText:[NSString stringWithFormat:@"%@ Lvl: %d", [Pet sharedInstance].petName, [Pet sharedInstance].petLevel]];
}

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
                     [self.btnExcercise setEnabled:NO];
                     [self animateEatingPet];
                     NSLog(@"Morfando como un Campeon");
                 }
             }
             
         }];
    }
}

//***************************************************************************
// Animaciones
//***************************************************************************

#pragma mark - Animations

-(void) animateEatingPet
{
    NSArray *img = @[[UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[0]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[1]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[2]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[3]]];
    [self.petImageView setAnimationImages:img];
    [self.petImageView setAnimationDuration:eatAnimationTime];
    [self.petImageView setAnimationRepeatCount:eatAnimationIterations];
    [self setNormalStatePetImage];
    [self.petImageView startAnimating];
    [[Pet sharedInstance] doEat: self.myFood.foodEnergyValue];
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
        [self.energyTimer autoInvalidate];
        [Pet sharedInstance].doingExcercise = NO;
    }
    else
    {
        [self.petImageView startAnimating];
        self.energyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateEnergyByExcercise) userInfo:nil repeats:YES];
        [Pet sharedInstance].doingExcercise = YES;
    }
}

- (void) animateExhaustPet
{
    NSArray *img = @[[UIImage imageNamed:[ImagesLoader sharedInstance].imgPetExhausto[0]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetExhausto[1]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetExhausto[2]],
                     [UIImage imageNamed:[ImagesLoader sharedInstance].imgPetExhausto[3]]];
    
    [self.petImageView setAnimationImages:img];
    [self.petImageView setAnimationDuration:exhaustAnimationTime];
    [self.petImageView setAnimationRepeatCount:1];
    [self setExhaustFinishImage];
    [self.petImageView startAnimating];
    
}

#pragma mark - Update Energy

- (void) updateEnergyByExcercise
{
    [[Pet sharedInstance] doExcercise];
    [[Pet sharedInstance] gainExperience];
}

#pragma mark - Food Delegate Metodos
//*************************************************************
// Food Delegate
//*************************************************************

- (void) didSelectFood:(PetFood *)food
{
    self.myFood = food;
    [self.imgViewFood setImage:[UIImage imageNamed:self.myFood.imagePath]];
}
//*************************************************************
// Metodos del Pet
//*************************************************************
#pragma  mark - Eventos del Pet

- (void) updatePetEnergyInProgressBar :(NSNotification*) notif
{
    float varValue = ((NSNumber*)notif.object).intValue;
    varValue = varValue / 100;
    
    [self updateEnergyProgress:varValue];
}

- (void) updateEnergyProgress: (float) value
{
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^(void)
     {
         [self.petEnergyBar setProgress:value animated:YES];
     }completion:^(BOOL finished)
     {
         if(finished)
         {
             [self.btnExcercise setEnabled:YES];
         }
     }];
}

- (void) updatePetExhaust
{
    [self.energyTimer autoInvalidate];
    [self.btnExcercise setEnabled:NO];
    [self.btnExcercise setTitle:@"Do Excercise" forState:UIControlStateNormal];
    [self animateExhaustPet];
}

- (void) setExhaustFinishImage
{
    [self.petImageView setImage:[UIImage imageNamed:[ImagesLoader sharedInstance].imgPetExhausto[3]]];
}

- (void) setNormalStatePetImage
{
    [self.petImageView setImage:[UIImage imageNamed:[ImagesLoader sharedInstance].imgPetComiendo[0]]];
}

- (void) updateExperience
{
    [self.lblExperience setText:[NSString stringWithFormat:@"%d / %d", [[Pet sharedInstance] getActualExp], [[Pet sharedInstance] getNeededExp]]];
    float actualExp = [[Pet sharedInstance] getActualExp];
    float barValue = actualExp/[[Pet sharedInstance] getNeededExp];
    [self.petExpProgressBar setProgress:barValue];
}

- (void) showLevelUp :(NSNotification*) notification
{
    int level = ((NSNumber*)notification.object).intValue;
    [[[UIAlertView alloc] initWithTitle:@"Congratulations" message:[NSString stringWithFormat:@"You raised level %d", level] delegate:self cancelButtonTitle:@"CONTINUE" otherButtonTitles:nil, nil] show];
    
    [self.lblPetName setText:[NSString stringWithFormat:@"%@ Lvl: %d", [Pet sharedInstance].petName, level]];
    
    // Enviamos la notificacion de level up
    NSDictionary* dic = @{@"code": CODE_IDENTIFIER,
                          @"name": [Pet sharedInstance].petName,
                          @"level": [NSNumber numberWithInt:[Pet sharedInstance].petLevel]
                        };
    [NotificationManager sendNotification:dic];
}

//********************************************
// Block para info del server
//********************************************

- (Success) getSuccess {
    
    __weak typeof(self) weakerSelf = self;
    
    return ^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        NSString* name = [responseObject objectForKey:@"name"];
        int level = ((NSNumber*)[responseObject objectForKey:@"level"]).intValue;
        int actualExp = ((NSNumber*)[responseObject objectForKey:@"experience"]).intValue;
        int energy = ((NSNumber*)[responseObject objectForKey:@"energy"]).intValue;
        PetType type = ((NSNumber*)[responseObject objectForKey:@"pet_type"]).intValue;
        
        [[Pet sharedInstance] reloadDataName:name level:level actualExp:actualExp energy:energy andPetType:type];
        
        [weakerSelf.lblPetName setText:[NSString stringWithFormat:@"%@ Lvl: %d", name, level]];
        [weakerSelf updateExperience];
        [weakerSelf.petImageView setImage:[UIImage imageNamed:[Pet sharedInstance].petImageName]];
        float barEnergy = energy;
        barEnergy = barEnergy / 100;
        [weakerSelf updateEnergyProgress:barEnergy];
    };
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
