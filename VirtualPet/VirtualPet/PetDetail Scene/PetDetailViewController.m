//
//  PetDetailViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 12/4/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetDetailViewController.h"

@interface PetDetailViewController ()

@property (strong, nonatomic) IBOutlet UIProgressView *energyProgress;
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UILabel *petNameLbl;

@end

@implementation PetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.petImageView.image = [UIImage imageNamed:self.thePet.petImageName];
    self.petNameLbl.text = [NSString stringWithFormat:@"%@ Lvl: %d", self.thePet.petName, self.thePet.petLevel];
    
    float energy = self.thePet.petEnergy;
    energy = energy /100;
    
    self.energyProgress.progress = energy;
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

//**************************************************************
// Constructor
//**************************************************************

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPet: (Pet*) pet;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        self.thePet = pet;
    }
    
    return self;
}

@end
