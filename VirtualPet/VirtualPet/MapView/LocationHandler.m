//
//  LocationHandler.m
//  VirtualPet
//
//  Created by Ezequiel on 12/1/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "LocationHandler.h"
#import "Pet.h"
#import "NetworkAccessObject.h"

@interface LocationHandler()

@property (strong, nonatomic) NetworkAccessObject* daoObject;

@end

@implementation LocationHandler

- (void) startTracking
{
    if(self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    if(self.daoObject == nil)
    {
        self.daoObject = [[NetworkAccessObject alloc]  init];
    }
    [self.locationManager setDelegate:self];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = 20; // En Metros
    [self.locationManager startUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* myLocation = locations[0];
    NSDate* eventDate = myLocation.timestamp;
    NSTimeInterval interval = [eventDate timeIntervalSinceNow];
    
    if(abs(interval) < 120.00)
    {
        //[manager stopUpdatingLocation];
        [Pet sharedInstance].location = myLocation;
        NSLog(@"Pet Location: %f/%f", [Pet sharedInstance].location.coordinate.latitude, [Pet sharedInstance].location.coordinate.longitude);
        [self.daoObject doPOSTPetUpdate];
    }
}

@end
