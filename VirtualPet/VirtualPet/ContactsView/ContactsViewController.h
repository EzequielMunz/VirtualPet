//
//  ContactsViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 12/5/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MyPet.h"
#import "ContactCell.h"

@interface ContactsViewController : UIViewController <MFMailComposeViewControllerDelegate, UITableViewDataSource, ContactDelegate>

@end
