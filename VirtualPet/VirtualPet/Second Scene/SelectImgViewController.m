//
//  SelectImgViewController.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "SelectImgViewController.h"

@interface SelectImgViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollImages;

@property (strong, nonatomic) IBOutlet UIButton *scrollImage1;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage2;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage3;
@property (strong, nonatomic) IBOutlet UIButton *scrollImage4;

@end

@implementation SelectImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollImages setScrollEnabled:YES];
    [self.scrollImages setContentSize:CGSizeMake(self.scrollImages.frame.size.width + self.scrollImage4.frame.size.width, self.scrollImages.frame.size.height)];
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
    switch (sender.tag) {
        case 0:
            self.petImageView.image = [UIImage imageNamed:@"ciervo_comiendo_1"];
            break;
        case 1:
            self.petImageView.image = [UIImage imageNamed:@"gato_comiendo_1"];
            break;
        case 2:
            self.petImageView.image = [UIImage imageNamed:@"jirafa_comiendo_1"];
            break;
        case 3:
            self.petImageView.image = [UIImage imageNamed:@"leon_comiendo_1"];
            break;
            
        default:
            break;
    }
}


- (IBAction)buttonContinueTouched:(id)sender
{
    
}

@end
