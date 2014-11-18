//
//  GameViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *petImage;
@property (strong, nonatomic) IBOutlet UIProgressView *petEnergyBar;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void) updatePetEnergy
{
    
}

@end
