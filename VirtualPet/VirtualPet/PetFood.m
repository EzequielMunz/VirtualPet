//
//  PetFood.m
//  VirtualPet
//
//  Created by Ezequiel on 11/20/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "PetFood.h"

@implementation PetFood

- (instancetype) initWithFood:(NSString *)name andImagePath:(NSString *)path
{
    self = [super init];
    
    if(self)
    {
        self.foodName = name;
        self.imagePath = path;
    }
    
    return self;
}

@end
