//
//  PetFood.m
//  VirtualPet
//
//  Created by Ezequiel on 11/20/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetFood.h"

@implementation PetFood

- (instancetype) initWithFood:(NSString *)name andImagePath:(NSString *)path andEnergyValue: (int) value
{
    self = [super init];
    
    if(self)
    {
        self.foodName = name;
        self.imagePath = path;
        self.foodEnergyValue = value;
    }
    
    return self;
}

@end
