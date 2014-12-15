//
//  FightViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 12/12/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "FightViewController.h"
#import "NSTimer+TimerWithAutoInvalidate.h"
#import "MyPet.h"

@interface FightViewController ()

@property (nonatomic) float maxPower;
@property (nonatomic) int contador;
@property (atomic) bool hitting;
@property (nonatomic, strong) Pet* enemyPet;

//---- UI
@property (strong, nonatomic) IBOutlet UILabel *lblNameEnemy;
@property (strong, nonatomic) IBOutlet UILabel *lblHPEnemy;
@property (strong, nonatomic) IBOutlet UIImageView *imgEnemy;
@property (strong, nonatomic) IBOutlet UILabel *lblMyName;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewMine;
@property (strong, nonatomic) IBOutlet UILabel *lblMyHP;

@end

@implementation FightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.hitting = NO;
    self.contador = 0;
    
    [self reloadViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self checkAccelerometer];
    [self setUpMultipeer];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.motionManager stopAccelerometerUpdates];
    
    [super viewDidDisappear:animated];
}

- (void) reloadViewData
{
    [self.lblHPEnemy setText:[NSString stringWithFormat:@"%d / 100", self.enemyPet.health]];
    [self.lblNameEnemy setText:self.enemyPet.petName];
    [self.imgEnemy setImage:[UIImage imageNamed:self.enemyPet.petImageName]];
    
    self.lblMyHP.text = [NSString stringWithFormat:@"%d / 100", [MyPet sharedInstance].health];
    self.lblMyName.text = [MyPet sharedInstance].petName;
    self.imgViewMine.image = [UIImage imageNamed:[MyPet sharedInstance].petImageName];
}

//**************************************************
// Conectivity
//**************************************************

- (void) setUpMultipeer{
    //  Setup peer ID
    self.myPeerID = [[MCPeerID alloc] initWithDisplayName:[MyPet sharedInstance].petName];
    
    //  Setup session
    self.mySession = [[MCSession alloc] initWithPeer:self.myPeerID];
    self.mySession.delegate = self;
    
    //  Setup BrowserViewController
    self.browserVC = [[MCBrowserViewController alloc] initWithServiceType:@"chat" session:self.mySession];
    self.browserVC.delegate = self;
    
    //  Setup Advertiser
    self.advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chat" discoveryInfo:nil session:self.mySession];
    [self.advertiser start];
}

- (IBAction)btnFindTouched:(id)sender
{
    [self presentViewController:self.browserVC animated:YES completion:nil];
}

#pragma marks MCBrowserViewControllerDelegate

// Notifies the delegate, when the user taps the done button
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [self dismissBrowser];
}

// Notifies delegate that the user taps the cancel button.
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [self dismissBrowser];
}

- (void) dismissBrowser
{
    [self.browserVC dismissViewControllerAnimated:YES completion:nil];
    [self sendData: [NSNumber numberWithInt:0]];
    [self reloadViewData];
}

- (void) sendData :(NSNumber*) attkPower{
    //  Retrieve text from chat box and clear chat box
    NSString *name = [MyPet sharedInstance].petName;
    NSString* image = [MyPet sharedInstance].petImageName;
    int health = [MyPet sharedInstance].health;
    
    NSDictionary* dic = @{@"name" : name,
                          @"image" : image,
                          @"health" : [NSNumber numberWithInt:health],
                          @"attackPower" : attkPower};
    //  Convert text to NSData
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    //  Send data to connected peers
    NSError *error;
    [self.mySession sendData:data toPeers:[self.mySession connectedPeers] withMode:MCSessionSendDataUnreliable error:&error];
}

// Remote peer changed state
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
}

// Received data from remote peer ******* Vamos a usar este *********
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    NSDictionary* dic = (NSDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    Pet* aux = [[Pet alloc] initWithDictionaryForFight:dic];
    self.enemyPet = aux;
    
    int attackPower = ((NSNumber*)[dic objectForKey:@"attackPower"]).intValue;
    
    [MyPet sharedInstance].health -= attackPower;
    [self reloadViewData];
}

// Received a byte stream from remote peer
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

// Start receiving a resource from remote peer
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}

// Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
}

//**************************************************
// Accelerometer
//**************************************************

- (void) checkAccelerometer
{
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData* accelerometer, NSError* error){
       
        //NSLog(@"X: %f", accelerometer.acceleration.x); // -> Derecha + <- Izquierda -
        //NSLog(@"Y: %f", accelerometer.acceleration.y); // Siempre Positivo
        //NSLog(@"Z: %f", accelerometer.acceleration.z); // Siempre Positivo
        
        float power = 0.0;

        if(accelerometer.acceleration.x > 3)
        {
            power = accelerometer.acceleration.x;
        }
        if(accelerometer.acceleration.y > 3 && accelerometer.acceleration.y > power)
        {
            power = accelerometer.acceleration.y;
        }
        if(accelerometer.acceleration.z > 2 && accelerometer.acceleration.z > power)
        {
            power = accelerometer.acceleration.z;
        }
        
        if(self.maxPower < power && !self.hitting)
        {
            self.contador = self.contador+1;
            self.maxPower = power;
            if(self.contador >= 4)
            {
                self.hitting = YES;
                [self hitEnemyPet: power];
            }
            self.maxPower = 0.0f;
            self.hitting = NO;
        }
    }];
}

- (void) hitEnemyPet: (int) power
{
    NSLog(@"Critish: %f", self.maxPower);
    self.contador = 0;
    self.maxPower = 0.0f;
    
    int hitPower = power * 3;
    [self sendData:[NSNumber numberWithInt:hitPower]];
    [self reloadViewData];
}

@end
