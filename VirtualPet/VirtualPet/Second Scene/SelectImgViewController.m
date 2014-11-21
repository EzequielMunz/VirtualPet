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
@property (nonatomic, strong) Pet* myPet;

@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollImages;

@property (strong, nonatomic) IBOutlet UIButton *scrollImage1;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage2;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage3;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage4;

@property (nonatomic) PetImageTag myTag;

@end

@implementation SelectImgViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetName:(NSString *)name
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        self.myPetName = name;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollImages setScrollEnabled:YES];
    [self.scrollImages setContentSize:CGSizeMake(self.scrollImages.frame.size.width + self.scrollImage4.frame.size.width, self.scrollImages.frame.size.height)];
    
    [self.lblPetName setText:self.myPetName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setTitle:@"Image"];
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
    PetImageTag enumTag = (PetImageTag) sender.tag;
    Pet* myPet;
    
    switch (enumTag) {
        case PET_CIERVO:
            myPet = [[Pet alloc] initWithType:@"Ciervo" petName:self.myPetName ImageNamed:@"ciervo_comiendo_1"];
            break;
        case PET_GATO:
            myPet = [[Pet alloc] initWithType:@"Gato" petName:self.myPetName ImageNamed:@"gato_comiendo_1"];
            break;
        case PET_JIRAFA:
            myPet = [[Pet alloc] initWithType:@"Jirafa" petName:self.myPetName ImageNamed:@"jirafa_comiendo_1"];
            break;
        case PET_LEON:
            myPet = [[Pet alloc] initWithType:@"Leon" petName:self.myPetName ImageNamed:@"leon_comiendo_1" ];
            break;
            
        default:
            break;
    }
    self.petImageView.image = [UIImage imageNamed:myPet.petImageName];
    self.myTag = enumTag;
    self.myPet = myPet;
}


- (IBAction)buttonContinueTouched:(id)sender
{
    if(self.myPet)
    {
        GameViewController *gameView = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle] andPet: self.myPet andImageTag:self.myTag];
        [self.navigationController pushViewController:gameView animated:YES];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Select Image" message:@"Plis, select a luc for ior pet. Inglish lesons bai maiself" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
