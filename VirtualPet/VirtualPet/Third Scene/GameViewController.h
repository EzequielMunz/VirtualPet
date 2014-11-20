//
//  GameViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetConfig.h"
#import "FoodViewController.h"

@interface GameViewController : UIViewController <FoodDelegate>

@property (nonatomic, strong) NSNumber  *petEnergyValue;

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetName:(NSString*) name andImageTag:(PetImageTag)tag;

- (void) updatePetEnergy;

@end
