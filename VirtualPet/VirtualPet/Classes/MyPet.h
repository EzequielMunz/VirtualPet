//
//  MyPet.h
//  VirtualPet
//
//  Created by Ezequiel on 12/2/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "Pet.h"

@interface MyPet : Pet <NSCoding>

+ (instancetype) sharedInstance;

+ (void) saveDataToDisk;

- (void) doExcercise;
- (void) doEat: (int) value;
- (void) gainExperience;

- (int) getActualExp;
- (int) getNeededExp;
- (int) getEnergy;

- (void) reloadDataName: (NSString*)name level: (int)level actualExp: (int)exp energy: (int)energy andPetType: (PetType)type;

@end
