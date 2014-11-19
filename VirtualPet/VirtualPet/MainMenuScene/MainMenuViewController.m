//
//  MainMenuViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/19/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "MainMenuViewController.h"
#import "FirstViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"Menu"];
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
- (IBAction)btnPlayTouched:(id)sender
{
    FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:firstView animated:YES];
}

@end
