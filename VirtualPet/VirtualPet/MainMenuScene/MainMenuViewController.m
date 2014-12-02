//
//  MainMenuViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/19/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "MainMenuViewController.h"
#import "FirstViewController.h"
#import "SelectImgViewController.h"
#import "GameViewController.h"
#import "NotificationManager.h"
#import "NetworkAccessObject.h"
#import "MyPet.h"
#import "LocationHandler.h"

@interface MainMenuViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnPlay;
@property (strong, nonatomic) NetworkAccessObject* daoObject;

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.daoObject = [[NetworkAccessObject alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:@"Menu"];
    [NotificationManager sendLocalNotification:@{@"name": @"name",
                                                 @"level": [NSNumber numberWithInt:2]
                                                 }];
    //[NotificationManager suscribeToChannel];
}

- (void) viewWillDisappear:(BOOL)animated
{
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
- (IBAction)btnPlayTouched:(id)sender
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:FIRST_STEP_KEY])
    {
        if([[NSUserDefaults standardUserDefaults] boolForKey:SECOND_STEP_KEY])
        {
            GameViewController* thirdView = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:thirdView animated:YES];
        }
        else
        {
            SelectImgViewController* secondView = [[SelectImgViewController alloc] initWithNibName:@"SelectImageViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:secondView animated:YES];
        }
    }
    else
    {
        FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:firstView animated:YES];
    }
}

- (IBAction)btnLoadGameTouched:(id)sender
{
    [self.daoObject doGETPetInfo:[self getSuccess]];
}

- (Success) getSuccess
{
    return ^(NSURLSessionDataTask* data, id responseObject){
      
        NSLog(@"JSON: %@", responseObject);
        NSString* name = [responseObject objectForKey:@"name"];
        int level = ((NSNumber*)[responseObject objectForKey:@"level"]).intValue;
        int actualExp = ((NSNumber*)[responseObject objectForKey:@"experience"]).intValue;
        int energy = ((NSNumber*)[responseObject objectForKey:@"energy"]).intValue;
        PetType type = ((NSNumber*)[responseObject objectForKey:@"pet_type"]).intValue;
        
        [[MyPet sharedInstance] reloadDataName:name level:level actualExp:actualExp energy:energy andPetType:type];
        
        GameViewController* game = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:game animated:YES];
        
    };
}

@end
