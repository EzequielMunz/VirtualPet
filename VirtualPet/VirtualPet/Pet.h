//
//  Pet.h
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

@property (nonatomic, strong) NSString* petName;
@property (nonatomic, strong) NSString* petImageName;
@property (nonatomic, strong) NSString* petType;

- (instancetype) initWithType: (NSString*) type petName: (NSString*)name ImageNamed:(NSString*)imageName;

@end
