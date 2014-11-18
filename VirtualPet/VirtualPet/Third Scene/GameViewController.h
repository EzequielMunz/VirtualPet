//
//  GameViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (nonatomic, strong) NSNumber  *petEnergyValue;

- (void) updatePetEnergy;

@end
