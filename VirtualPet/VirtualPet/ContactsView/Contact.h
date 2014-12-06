//
//  Contact.h
//  VirtualPet
//
//  Created by Ezequiel on 12/6/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* eMail;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* company;

- (instancetype) initWithFirstName: (NSString*) first LastName: (NSString*) last eMail: (NSString*) eMail phone: (NSString*) phone andCompany: (NSString*) company;

@end
