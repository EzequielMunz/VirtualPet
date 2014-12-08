//
//  ContactCell.h
//  VirtualPet
//
//  Created by Ezequiel on 12/6/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol ContactDelegate <NSObject>

@required
- (void) openMailComposer: (NSString*) toRecipient;
- (void) doACall: (NSString*) toPhone;

@end

@interface ContactCell : UITableViewCell

@property (nonatomic, strong) Contact* myContact;
@property (nonatomic, weak) id <ContactDelegate> delegate;

- (instancetype) initWithContact: (Contact*)contact;

- (void) fillWithContact: (Contact*) contact;

@end
