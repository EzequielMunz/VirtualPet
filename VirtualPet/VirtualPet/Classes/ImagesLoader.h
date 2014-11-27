//
//  ImagesLoader.h
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PetConfig.h"

@interface ImagesLoader : NSObject

@property (nonatomic, strong) NSArray* imgPetComiendo;
@property (nonatomic, strong) NSArray* imgPetEjercicio;
@property (nonatomic, strong) NSArray* imgPetExhausto;

- (void) loadPetComiendoArrayWithTag: (PetImageTag)tag;

+ (instancetype) sharedInstance;

@end
