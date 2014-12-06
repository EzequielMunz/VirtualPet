//
//  ContactManager.h
//  VirtualPet
//
//  Created by Ezequiel on 12/6/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "Contact.h"

@interface ContactManager : NSObject

@property (nonatomic) ABAddressBookRef addressBookRef;
@property (nonatomic, strong) NSMutableArray* contactList;

+ (instancetype) sharedInstance;

- (void) getContactList;

- (void) getAuthorization;

@end
