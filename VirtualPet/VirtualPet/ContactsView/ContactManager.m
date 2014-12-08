//
//  ContactManager.m
//  VirtualPet
//
//  Created by Ezequiel on 12/6/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "ContactManager.h"

@implementation ContactManager

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    
    __strong static ContactManager* _sharedObject = nil;
    
    dispatch_once(&pred, ^(void){
        _sharedObject = [[ContactManager alloc] init];
    });
    
    return  _sharedObject;
}

- (void) getContactList
{
    self.addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    self.contactList = [[NSMutableArray alloc] init];
    
    CFArrayRef allContacts = ABAddressBookCopyArrayOfAllPeople(self.addressBookRef);
    CFIndex contactCount = ABAddressBookGetPersonCount(self.addressBookRef);
    
    for (int i = 0; i < contactCount; i++)
    {
        ABRecordRef reference = CFArrayGetValueAtIndex(allContacts, i);
        
        NSString* firstName = (__bridge NSString*)ABRecordCopyValue(reference, kABPersonFirstNameProperty);
        NSString* lastName = (__bridge NSString*)ABRecordCopyValue(reference, kABPersonLastNameProperty);
        NSString* company = (__bridge NSString*)ABRecordCopyValue(reference, kABPersonOrganizationProperty);
        
        ABMultiValueRef phonesRef = ABRecordCopyValue(reference, kABPersonPhoneProperty);
        NSArray* phones = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(phonesRef);
        NSString* mainPhone = @"";
        if(phones && [phones count] > 0)
        {
            mainPhone = phones[0];
        }
        NSLog(@"Phone: %@", mainPhone);
        
        ABMultiValueRef eMailsRef = ABRecordCopyValue(reference, kABPersonEmailProperty);
        NSArray* eMails = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(eMailsRef);
        NSString* mainEmail = @"";
        if(eMails && [eMails count] > 0)
        {
            mainEmail = eMails[0];
        }
        NSLog(@"EMAIL: %@", mainEmail);
        
        Contact* contact = [[Contact alloc] initWithFirstName:firstName LastName:lastName eMail:mainEmail phone:mainPhone andCompany:company];
        [self.contactList addObject:contact];
    }
    NSLog(@"Contactos: %lu", (unsigned long)self.contactList.count);
}

- (void) getAuthorization
{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(self.addressBookRef, ^(bool granted, CFErrorRef error) {
            // Es la primera vez que accedemos a dichos contactos
            if(error)
            {
                NSLog(@"Error: %@", error);
            }
            [self getContactList];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // El usuario ya nos había autorizado previamente el acceso
        [self getContactList];
    }
    else {
        // El usuario ya nos había denegado previamente el acceso
        NSLog(@"No tenes permiso weon");
    }
}

@end
