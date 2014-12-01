//
//  Pet.h
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "PetConfig.h"

extern NSString* const EVENT_UPDATE_ENERGY;
extern NSString* const EVENT_SET_EXHAUST;
extern NSString* const EVENT_LEVEL_UP;
extern NSString* const EVENT_UPDATE_EXPERIENCE;
extern NSString* const EVENT_RELOAD_DATA;

@interface Pet : NSObject

@property (nonatomic, strong) NSString* petName;
@property (nonatomic, strong) NSString* petImageName;
@property (nonatomic) PetType petType;
@property (nonatomic) BOOL doingExcercise;
@property (nonatomic, strong) NSString* userID;
@property (nonatomic, strong) CLLocation* location;

@property (nonatomic) int petLevel;

- (instancetype) initWithDictionary: (NSDictionary*) dic;

+ (instancetype) sharedInstance;

- (void) doExcercise;
- (void) doEat: (int) value;
- (void) gainExperience;

- (int) getActualExp;
- (int) getNeededExp;
- (int) getEnergy;
- (void) reloadDataName: (NSString*)name level: (int)level actualExp: (int)exp energy: (int)energy andPetType: (PetType)type;

@end
