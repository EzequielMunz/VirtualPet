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

- (void) setPetImage:(UIImage *)image
{
    self.petImageView.image = image;
}

- (IBAction)scrollImageTouched:(UIButton*)sender
{
    UIImage *myImage;
    
    switch (sender.tag) {
        case 0:
            myImage=self.scrollImage1.imageView.image;
            break;
        case 1:
            myImage=self.scrollImage2.imageView.image;
            break;
        case 2:
            myImage=self.scrollImage3.imageView.image;
            break;
        case 3:
            myImage=self.scrollImage4.imageView.image;
            break;
            
        default:
            break;
    }
    
    [self setPetImage:myImage];
}

- (IBAction)buttonContinueTouched:(id)sender
{
    
}

@end
