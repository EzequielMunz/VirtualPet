//
//  Pet.h
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PetConfig.h"

extern NSString* const EVENT_UPDATE_ENERGY;
extern NSString* const EVENT_SET_EXHAUST;
extern NSString* const EVENT_LEVEL_UP;
extern NSString* const EVENT_UPDATE_EXPERIENCE;

@interface Pet : NSObject

@property (nonatomic, strong) NSString* petName;
@property (nonatomic, strong) NSString* petImageName;
@property (nonatomic) PetType petType;
@property (nonatomic) BOOL doingExcercise;

//- (instancetype) initWithType: (NSString*) type petName: (NSString*)name ImageNamed:(NSString*)imageName;

+ (instancetype) sharedInstance;

- (void) doExcercise;
- (void) doEat: (int) value;
- (void) gainExperience;

@end
