//
//  SelectImgViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectImgViewController : UIViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetName:(NSString*) name;

- (IBAction)setImage:(UIButton*)sender;

@end
