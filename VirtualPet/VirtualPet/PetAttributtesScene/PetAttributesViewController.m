//
//  PetAttributesViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/25/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetAttributesViewController.h"

@interface PetAttributesViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewPet;
@property (strong, nonatomic) IBOutlet UILabel *lblLevel;
@property (strong, nonatomic) IBOutlet UIProgressView *petExpProgressBar;
@property (strong, nonatomic) IBOutlet UILabel *lblExperience;

@end

@implementation PetAttributesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblPetName setText:[Pet sharedInstance].petName];
    [self.imgViewPet setImage:[UIImage imageNamed:[Pet sharedInstance].petImageName]];
    
    // Personalizacion de progress bar
    [self.petExpProgressBar setTransform:CGAffineTransformMakeScale(1.0, 7.0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Suscribirse a eventos
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLevel:) name:EVENT_LEVEL_UP object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateExperience:) name:EVENT_UPDATE_EXPERIENCE object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) updateLevel: (NSNotification*) notif
{
    [self.lblLevel setText:[NSString stringWithFormat:@"%d",((NSNumber*)notif.object).intValue]];
}

- (void) updateExperience: (NSNotification*) notif
{
    NSArray* obj = (NSArray*)notif.object;
    
    float actualExp = ((NSNumber*)obj[0]).intValue;
    float neededExp = ((NSNumber*)obj[1]).intValue;
    
    float barValue = actualExp/neededExp;
    
    [self.petExpProgressBar setProgress:barValue];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
