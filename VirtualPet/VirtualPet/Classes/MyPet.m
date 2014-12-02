//
//  MyPet.m
//  VirtualPet
//
//  Created by Ezequiel on 12/2/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "MyPet.h"
#import "NetworkAccessObject.h"

NSString* const KEY_NAME = @"pet_name";
NSString* const KEY_LEVEL = @"pet_level";
NSString* const KEY_IMAGE = @"pet_image";
NSString* const KEY_ENERGY = @"pet_energy";
NSString* const KEY_EXPERIENCE = @"pet_experience";
NSString* const KEY_TYPE = @"pet_type";
NSString* const KEY_LOCATION = @"pet_location";
NSString* const KEY_FULL_PET = @"pet_object";

@interface MyPet ()

@property (nonatomic) int petNeededExperience;
@property (nonatomic) int petActualExperience;
@property (nonatomic, strong) NetworkAccessObject* daoObject;

@end

@implementation MyPet

 __strong static id _sharedObject = nil;

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
        [self initDataAccessObject];
    }
    
    return self;
}

//***********************************************
// Coder Methods
//***********************************************

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        [self setPetName: [aDecoder decodeObjectForKey:KEY_NAME]];
        [self setPetLevel:((NSNumber*)[aDecoder decodeObjectForKey:KEY_LEVEL]).intValue];
        [self setPetEnergy:((NSNumber*)[aDecoder decodeObjectForKey:KEY_ENERGY]).intValue];
        [self setPetImageName:[aDecoder decodeObjectForKey:KEY_IMAGE]];
        [self setPetActualExperience:((NSNumber*)[aDecoder decodeObjectForKey:KEY_EXPERIENCE]).intValue];
        [self setPetType:(PetType)((NSNumber*)[aDecoder decodeObjectForKey:KEY_TYPE]).intValue];
        [self setLocation:[aDecoder decodeObjectForKey:KEY_LOCATION]];
        [self calculateNeededExperience];
        [self initDataAccessObject];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.petName forKey:KEY_NAME];
    [aCoder encodeObject:[NSNumber numberWithInt:self.petLevel] forKey:KEY_LEVEL];
    [aCoder encodeObject:[NSNumber numberWithInt:self.petEnergy] forKey:KEY_ENERGY];
    [aCoder encodeObject:self.petImageName forKey:KEY_IMAGE];
    [aCoder encodeObject:[NSNumber numberWithInt:self.petActualExperience] forKey:KEY_EXPERIENCE];
    [aCoder encodeObject:[NSNumber numberWithInt:self.petType] forKey:KEY_TYPE];
    [aCoder encodeObject:self.location forKey:KEY_LOCATION];
}

//********************************************************************
// Singleton
//********************************************************************

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    
    dispatch_once(&pred , ^{
        
        [MyPet loadDataFromDisk];
        if(!_sharedObject)
        {
            _sharedObject = [[self alloc] initWithEnergy:100];
        }
    });
    
    return _sharedObject;
}

- (void) initDataAccessObject
{
    self.daoObject = [[NetworkAccessObject alloc] init];
}

//********************************************************************
// Guardad Los Datos
//********************************************************************

+ (NSString*) pathForDataFile
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* folderPath = @"~/Library/Application Support/VirtualPet/";
    folderPath = [folderPath stringByExpandingTildeInPath];
    
    if([fileManager fileExistsAtPath:folderPath] == NO)
    {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString* filePath = [folderPath stringByAppendingPathComponent:@"VirtualPet.data"];
    return filePath;
}

+ (void) saveDataToDisk
{
    NSString* path = [MyPet pathForDataFile];
    
    NSMutableDictionary* rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue: [MyPet sharedInstance] forKey:KEY_FULL_PET];
    [NSKeyedArchiver archiveRootObject:rootObject toFile:path];
}

+ (void) loadDataFromDisk
{
    NSString *path = [MyPet pathForDataFile];
    NSDictionary* obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _sharedObject = [obj objectForKey:KEY_FULL_PET];
    
    //_sharedObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
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
// Level Methods
//********************************************************************

- (void) levelUp
{
    self.petLevel++;
    [self calculateNeededExperience];
    self.petActualExperience = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LEVEL_UP object:[NSNumber numberWithInt:self.petLevel]];
    
    [self.daoObject doPOSTPetUpdate];
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
