//
//  NotificationManager.m
//  VirtualPet
//
//  Created by Ezequiel on 11/28/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "NotificationManager.h"

NSString* const CHANNEL_NAME = @"PeleaDeMascotas";

@implementation NotificationManager

+ (void) suscribeToChannel
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:CHANNEL_NAME forKey:@"channels"];
    [currentInstallation saveInBackground];
}

+ (void) unsuscribeFromChannel
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation removeObject:CHANNEL_NAME forKey:@"channels"];
    [currentInstallation saveInBackground];
}

+ (void) sendNotification:(NSDictionary *)data
{
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:[NSArray arrayWithObjects:CHANNEL_NAME, nil]];
    [push setData:data];
    [push sendPushInBackground];
}

+ (void) sendLocalNotification: (NSDictionary*)dic
{
    UILocalNotification *localNotification =[[UILocalNotification alloc]init];
    
    // Notification details
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatCalendar = [NSCalendar currentCalendar];
    localNotification.alertBody = @"Aca te llega una noti con un par de cosas";
    localNotification.alertAction = @"GO";
    localNotification.userInfo = dic;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    
    // Schedule the notification
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

@end
