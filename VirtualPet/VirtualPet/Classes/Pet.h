//
//  Pet.h
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>
#import "PetConfig.h"

extern NSString* const EVENT_UPDATE_ENERGY;
extern NSString* const EVENT_SET_EXHAUST;
extern NSString* const EVENT_LEVEL_UP;
extern NSString* const EVENT_UPDATE_EXPERIENCE;
extern NSString* const EVENT_RELOAD_DATA;

@interface Pet : NSManagedObject

@property (nonatomic, strong) NSString* petName;
@property (nonatomic, strong) NSString* petImageName;
@property (nonatomic, assign) PetType petType;
@property (nonatomic, assign) BOOL doingExcercise;
@property (nonatomic, strong) NSString* userID;
@property (nonatomic, strong) CLLocation* location;
@property (nonatomic, assign) double locationLat;
@property (nonatomic, assign) double locationLon;
@property (nonatomic, assign) int petEnergy;
@property (nonatomic, assign) int petLevel;

- (instancetype) initWithDictionary: (NSDictionary*) dic;

@end
