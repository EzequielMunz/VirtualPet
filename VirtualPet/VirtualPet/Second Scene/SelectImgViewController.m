//
//  SelectImgViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "SelectImgViewController.h"
#import "PetConfig.h"
#import "GameViewController.h"

@interface SelectImgViewController ()

@property (strong, nonatomic) NSString *myPetName;

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
    
    [self setTitle:@"Image"];
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

- (IBAction)setImage:(UIButton*)sender
{
    PetImageTag enumTag = (PetImageTag) sender.tag;
    switch (enumTag) {
        case PET_CIERVO:
            self.petImageView.image = [UIImage imageNamed:@"ciervo_comiendo_1"];
            break;
        case PET_GATO:
            self.petImageView.image = [UIImage imageNamed:@"gato_comiendo_1"];
            break;
        case PET_JIRAFA:
            self.petImageView.image = [UIImage imageNamed:@"jirafa_comiendo_1"];
            break;
        case PET_LEON:
            self.petImageView.image = [UIImage imageNamed:@"leon_comiendo_1"];
            break;
            
        default:
            break;
    }
    
    self.myTag = enumTag;
}


- (IBAction)buttonContinueTouched:(id)sender
{
    GameViewController *gameView = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle] andPetName:self.myPetName andImageTag:self.myTag];
    [self.navigationController pushViewController:gameView animated:YES];
    
}

@end
