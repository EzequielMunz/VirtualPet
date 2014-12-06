//
//  Contact.m
//  VirtualPet
//
//  Created by Ezequiel on 12/6/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype) initWithFirstName: (NSString*) first LastName: (NSString*) last eMail: (NSString*) eMail phone: (NSString*) phone andCompany: (NSString*) company
{
    self = [super init];
    
    if(self)
    {
        self.firstName = first;
        self.lastName = last;
        self.eMail = eMail;
        self.phone = phone;
        self.company = company;
    }
    
    return self;
}

@end
