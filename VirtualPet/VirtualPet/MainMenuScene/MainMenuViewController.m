//
//  MainMenuViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/19/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "MainMenuViewController.h"
#import "FirstViewController.h"
#import "NotificationManager.h"

@interface MainMenuViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnPlay;

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:firstView animated:YES];
}

@end
