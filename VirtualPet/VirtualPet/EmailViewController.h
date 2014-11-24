//
//  EmailViewController.h
//  VirtualPet
//
//  Created by Ezequiel on 11/22/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface EmailViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic) MFMailComposeViewController *myMailView;
@property (nonatomic, strong) NSString* petName;

- (instancetype) initWithPetName: (NSString*) petName;

- (void) sendMail: (id) sender;

@end
