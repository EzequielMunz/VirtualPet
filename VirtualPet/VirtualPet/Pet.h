//
//  Pet.h
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PetConfig.h"

@protocol PetDelegate <NSObject>

@required
- (void) updateEnergyBarByExcercise: (int) value;
- (void) updateEnergyBarByEating: (int) value;

@end

@interface Pet : NSObject

@property (nonatomic, strong) NSString* petName;
@property (nonatomic, strong) NSString* petImageName;
@property (nonatomic) PetType petType;
@property (nonatomic) BOOL doingExcercise;
@property (nonatomic, weak) id <PetDelegate> delegate;

//- (instancetype) initWithType: (NSString*) type petName: (NSString*)name ImageNamed:(NSString*)imageName;

+ (instancetype) sharedInstance;

- (void) doExcercise;
- (void) doEat;

@end
