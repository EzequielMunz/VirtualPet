//
//  SelectImgViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "SelectImgViewController.h"
#import "PetConfig.h"
#import "MyPet.h"
#import "GameViewController.h"

@interface SelectImgViewController ()

@property (nonatomic) BOOL imgSelected;

@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollImages;

@property (strong, nonatomic) IBOutlet UIButton *scrollImage1;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage2;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage3;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage4;

@property (nonatomic) PetType myTag;

@end

@implementation SelectImgViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        self.imgSelected = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblPetName setText:[MyPet sharedInstance].petName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:@"Image"];
    
    [self.scrollImages setScrollEnabled:YES];
    [self.scrollImages setContentSize:CGSizeMake(self.scrollImages.frame.size.width + self.scrollImage4.frame.size.width, self.scrollImages.frame.size.height)];
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

- (IBAction)setImage:(UIButton*)sender
{
    PetType enumTag = (PetType) sender.tag;
    
    [[MyPet sharedInstance] setUserID:@"em3896"];
    
    switch (enumTag) {
        case TYPE_CIERVO:
            [[MyPet sharedInstance] setPetType:TYPE_CIERVO];
            [[MyPet sharedInstance] setPetImageName:@"ciervo_comiendo_1"];
            break;
        case TYPE_GATO:
            [[MyPet sharedInstance] setPetType:TYPE_GATO];
            [[MyPet sharedInstance] setPetImageName:@"gato_comiendo_1"];
            break;
        case TYPE_JIRAFA:
            [[MyPet sharedInstance] setPetType:TYPE_JIRAFA];
            [[MyPet sharedInstance] setPetImageName:@"jirafa_comiendo_1"];
            break;
        case TYPE_LEON:
            [[MyPet sharedInstance] setPetType:TYPE_LEON];
            [[MyPet sharedInstance] setPetImageName:@"leon_comiendo_1"];
            break;
            
        default:
            break;
    }
    self.petImageView.image = [UIImage imageNamed:[MyPet sharedInstance].petImageName];
    self.myTag = enumTag;
    self.imgSelected = YES;
}


- (IBAction)buttonContinueTouched:(id)sender
{
    if(self.imgSelected)
    {
        GameViewController *gameView = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SECOND_STEP_KEY];
        
        [self.navigationController pushViewController:gameView animated:YES];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Select Image" message:@"Plis, select a luc for ior pet. Inglish lesons bai maiself" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
