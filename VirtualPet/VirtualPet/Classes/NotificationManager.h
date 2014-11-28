//
//  NotificationManager.h
//  VirtualPet
//
//  Created by Ezequiel on 11/28/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface NotificationManager : NSObject

+ (void) suscribeToChannel;
+ (void) unsuscribeFromChannel;
+ (void) sendNotification: (NSDictionary*)data;
+ (void) sendLocalNotification: (NSDictionary*)data;

@end
