//
//  FoodViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 11/20/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetFood.h"

@protocol FoodDelegate <NSObject>

@required
- (void) didSelectFood:(PetFood*) food;

@end

@interface FoodViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <FoodDelegate> foodDelegate;

@end
