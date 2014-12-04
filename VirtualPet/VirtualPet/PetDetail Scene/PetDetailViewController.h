//
//  PetDetailViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 12/4/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@interface PetDetailViewController : UIViewController

@property (nonatomic, strong) Pet* thePet;

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPet: (Pet*) pet;

@end
