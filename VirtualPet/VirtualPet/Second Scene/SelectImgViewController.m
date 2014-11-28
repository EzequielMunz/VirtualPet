//
//  SelectImgViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "SelectImgViewController.h"
#import "PetConfig.h"
#import "Pet.h"
#import "GameViewController.h"

@interface SelectImgViewController ()

@property (strong, nonatomic) NSString *myPetName;
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

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetName:(NSString *)name
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        self.myPetName = name;
        self.imgSelected = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblPetName setText:self.myPetName];
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
    
    [[Pet sharedInstance] setPetName:self.myPetName];
    
    switch (enumTag) {
        case TYPE_CIERVO:
            [[Pet sharedInstance] setPetType:TYPE_CIERVO];
            [[Pet sharedInstance] setPetImageName:@"ciervo_comiendo_1"];
            break;
        case TYPE_GATO:
            [[Pet sharedInstance] setPetType:TYPE_GATO];
            [[Pet sharedInstance] setPetImageName:@"gato_comiendo_1"];
            break;
        case TYPE_JIRAFA:
            [[Pet sharedInstance] setPetType:TYPE_JIRAFA];
            [[Pet sharedInstance] setPetImageName:@"jirafa_comiendo_1"];
            break;
        case TYPE_LEON:
            [[Pet sharedInstance] setPetType:TYPE_LEON];
            [[Pet sharedInstance] setPetImageName:@"leon_comiendo_1"];
            break;
            
        default:
            break;
    }
    self.petImageView.image = [UIImage imageNamed:[Pet sharedInstance].petImageName];
    self.myTag = enumTag;
    self.imgSelected = YES;
}


- (IBAction)buttonContinueTouched:(id)sender
{
    if(self.imgSelected)
    {
        GameViewController *gameView = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle] andImageTag:self.myTag];
        
        [self.navigationController pushViewController:gameView animated:YES];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Select Image" message:@"Plis, select a luc for ior pet. Inglish lesons bai maiself" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
