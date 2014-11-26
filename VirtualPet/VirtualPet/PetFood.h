//
//  PetFood.h
//  VirtualPet
//
//  Created by Ezequiel on 11/20/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetFood : NSObject

@property (nonatomic, strong) NSString *foodName;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic) int foodEnergyValue;

- (instancetype) initWithFood:(NSString*) name andImagePath:(NSString*) path andEnergyValue: (int) value;

@end
