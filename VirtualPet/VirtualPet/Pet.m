//
//  Pet.m
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "Pet.h"

@interface Pet ()
@property (nonatomic) int petEnergy;
@property (nonatomic) int petLevel;

@end

@implementation Pet

- (instancetype) initWithEnergy: (int) energy
{
    self = [super init];
    
    if(self)
    {
        self.petEnergy = energy;
        self.petLevel = 1;
        self.doingExcercise = NO;
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

// Actualizar energia (Ejercicio)
- (void) doExcercise
{
    if(self.petEnergy > 0)
    {
        self.petEnergy -= 10;
    }
    if ([self.delegate respondsToSelector:@selector(updateEnergyBarByExcercise:)]){
        [self.delegate updateEnergyBarByExcercise:self.petEnergy];
    }
}

// Actualizar energia (Comer)
- (void) doEat
{
    self.petEnergy = 100;
    if ([self.delegate respondsToSelector:@selector(updateEnergyBarByEating:)]){
        [self.delegate updateEnergyBarByEating:self.petEnergy];
    }
}

/*- (instancetype) initWithType: (NSString*) type petName:(NSString *)name ImageNamed:(NSString *)imageName
{
    self = [super init];
    
    if(self)
    {
        self.petImageName = imageName;
        self.petName = name;
        self.petType = type;
    }
    return self;
}*/



@end
