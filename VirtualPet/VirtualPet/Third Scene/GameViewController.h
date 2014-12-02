//
//  GameViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "PetConfig.h"
#import "FoodViewController.h"
#import "MyPet.h"

@interface GameViewController : UIViewController <FoodDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate>

extern float const eatAnimationTime;
extern int const eatAnimationIterations;

@property (nonatomic, strong) NSNumber  *petEnergyValue;

@end
