//
//  Pet.m
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "Pet.h"

@interface Pet ()


@end

@implementation Pet

- (instancetype) initWithType: (NSString*) type petName:(NSString *)name ImageNamed:(NSString *)imageName
{
    self = [super init];
    
    if(self)
    {
        self.petImageName = imageName;
        self.petName = name;
        self.petType = type;
    }
    return self;
}



@end
