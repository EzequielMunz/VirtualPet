//
//  Pet.m
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "Pet.h"
#import "NetworkAccessObject.h"

NSString* const EVENT_UPDATE_ENERGY = @"UPDATE_ENERGY";
NSString* const EVENT_SET_EXHAUST = @"SET_EXHAUST";
NSString* const EVENT_LEVEL_UP = @"LEVEL_UP";
NSString* const EVENT_UPDATE_EXPERIENCE = @"UPDATE_EXPERIENCE";
NSString* const EVENT_RELOAD_DATA = @"RELOAD_DATA";

@interface Pet ()
@property (nonatomic) int petEnergy;
@property (nonatomic) int petNeededExperience;
@property (nonatomic) int petActualExperience;
@property (nonatomic, strong) NetworkAccessObject* daoObject;

@end

@implementation Pet

- (instancetype) initWithEnergy: (int) energy
{
    self = [super init];
    
    if(self)
    {
        self.petEnergy = energy;
        self.petLevel = 1;
        self.petActualExperience = 0;
        self.petNeededExperience = 100;
        self.doingExcercise = NO;
        self.daoObject = [[NetworkAccessObject alloc] init];
    }
    
    return self;
}

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred , ^{
        _sharedObject = [[self alloc] initWithEnergy:100];
    });
    
    return _sharedObject;
}

//********************************************************************
// Actualizar Estado
//********************************************************************

// Actualizar energia (Ejercicio)
- (void) doExcercise
{
    if(self.petEnergy > 0)
    {
        self.petEnergy -= 10;
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UPDATE_ENERGY object:[NSNumber numberWithInt:self.petEnergy]];
    }
    else
    {
        self.doingExcercise = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_SET_EXHAUST object:[NSNumber numberWithInt:self.petEnergy]];
    }
}

// Actualizar energia (Comer)
- (void) doEat: (int) value
{
    self.petEnergy += value;
    if(self.petEnergy > 100)
    {
        self.petEnergy = 100;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UPDATE_ENERGY object:[NSNumber numberWithInt:self.petEnergy]];
}

//********************************************************************
// Level Methods
//********************************************************************

- (void) levelUp
{
    self.petLevel++;
    [self calculateNeededExperience];
    self.petActualExperience = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LEVEL_UP object:[NSNumber numberWithInt:self.petLevel]];
    
    [self.daoObject doPOSTPetLevelUp];
}

- (void) calculateNeededExperience
{
    // Formula de experiencia : exp = 100 * petLevel ^ 2;
    self.petNeededExperience = 100 * (int) pow (self.petLevel ,2);
}

- (void) gainExperience
{
    self.petActualExperience += 15;
    if(self.petActualExperience > self.petNeededExperience)
    {
        [self levelUp];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UPDATE_EXPERIENCE object:@[[NSNumber numberWithInt:self.petActualExperience], [NSNumber numberWithInt:self.petNeededExperience]]];
}

- (int) getActualExp
{
    return self.petActualExperience;
}

- (int) getNeededExp
{
    return self.petNeededExperience;
}

- (int) getEnergy
{
    return self.petEnergy;
}

//********************************************************************
// Reload Data from DAO
//********************************************************************

- (void) reloadDataName: (NSString*)name level: (int)level actualExp: (int)exp energy: (int)energy andPetType:(PetType)type
{
    self.petName = name;
    self.petLevel = level;
    self.petActualExperience = exp;
    self.petEnergy = energy;
    
    switch (type) {
        case TYPE_CIERVO:
            self.petImageName = @"ciervo_comiendo_1";
            break;
        case TYPE_GATO:
            self.petImageName = @"gato_comiendo_1";
            break;
        case TYPE_JIRAFA:
            self.petImageName = @"jirafa_comiendo_1";
            break;
        case TYPE_LEON:
            self.petImageName = @"leon_comiendo_1";
            break;
            
        default:
            break;
    }
    
    [self calculateNeededExperience];
    
    /*[[NSNotificationCenter defaultCenter] postNotificationName:EVENT_RELOAD_DATA object:[NSNumber numberWithInt:self.petEnergy]];
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UPDATE_EXPERIENCE object:@[[NSNumber numberWithInt:self.petActualExperience], [NSNumber numberWithInt:self.petNeededExperience]]];
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UPDATE_ENERGY object:[NSNumber numberWithInt:self.petEnergy]];*/
}


@end
