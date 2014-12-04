//
//  AppDelegate.m
//  VirtualPet
//
//  Created by Ezequiel on 11/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"
#import "GameViewController.h"
#import "SelectImgViewController.h"
#import "PetConfig.h"
#import "MyPet.h"
#import "PetDetailViewController.h"
#import "NetworkAccessObject.h"

@interface AppDelegate ()

@property (nonatomic, strong) NetworkAccessObject* dao;

@end

@implementation AppDelegate


/*- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.dao = [[NetworkAccessObject alloc] init];
    
    UINavigationController* navControllerHome;
    MainMenuViewController* home = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    
    navControllerHome = [[UINavigationController alloc] initWithRootViewController:home];
   
    //--------------------------
    
    [navControllerHome.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [navControllerHome.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.window setRootViewController:navControllerHome];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Codigo de Parse
    [Parse setApplicationId:@"guhchukKgURzzZVCHBFOxyD35VHeMQm3EUZEdJvD"
                  clientKey:@"SnnbrQ9yOemJspA7LRt1MCACFFUYNkbQ1k2IM1vH"];
    
    // Register for Push Notitications
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
#endif
    
    // Local Notification
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        // Hacer Algo
    }

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [MyPet saveDataToDisk];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [MyPet saveDataToDisk];
}

//***********************************************************
// Abrir desde URL
//***********************************************************

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"URL: %@", url);
    
    NSString* code = [url lastPathComponent];
    [self.dao doGETPetInfoByCode:code withBlock:[self getCodeSuccess]];
    
    return YES;
}

- (Success) getCodeSuccess
{
    __weak typeof (self) weakerSelf = self;
    
    return ^(NSURLSessionDataTask *task, id responseObject){
        Pet* gettedPet = [[Pet alloc] initWithDictionary:responseObject];
        
        PetDetailViewController* view = [[PetDetailViewController alloc] initWithNibName:@"PetDetailViewController" bundle:[NSBundle mainBundle] andPet:gettedPet];
        [(UINavigationController*)weakerSelf.window.rootViewController pushViewController:view animated:YES];
    };
}

//***********************************************************
// Metodos para Notifications
//***********************************************************

# pragma mark - User Notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    
    NSLog(@"Successfully got a push token: %@", deviceToken);
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif
{
    NSLog(@"Notificacion: %@", notif.userInfo);
    app.applicationIconBadgeNumber = notif.applicationIconBadgeNumber - 1;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if([[userInfo objectForKey:@"code"] isEqualToString:@"em3896"])
    {
        [self processPush:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if([[userInfo objectForKey:@"code"] isEqualToString:@"em3896"])
    {
        [self processPush:userInfo];
    }
}

- (void) processPush:(NSDictionary*) userInfo
{
    [PFPush handlePush:userInfo];
    
    NSString* name = [userInfo objectForKey:@"name"];
    int level = ((NSNumber*)[userInfo objectForKey:@"level"]).intValue;
    
    NSString* message = [NSString stringWithFormat:@"El pet %@ ha subido al nivel %d", name, level];
    
    [[[UIAlertView alloc] initWithTitle:@"Noti" message:message delegate:self cancelButtonTitle:@" GO!! " otherButtonTitles:nil, nil] show];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to register for push notifications! Error was: %@", [error localizedDescription]);
}

@end
