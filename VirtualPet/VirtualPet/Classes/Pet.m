//
//  Pet.m
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "Pet.h"
#import "DataModelManager.h"

NSString* const EVENT_UPDATE_ENERGY = @"UPDATE_ENERGY";
NSString* const EVENT_SET_EXHAUST = @"SET_EXHAUST";
NSString* const EVENT_LEVEL_UP = @"LEVEL_UP";
NSString* const EVENT_UPDATE_EXPERIENCE = @"UPDATE_EXPERIENCE";
NSString* const EVENT_RELOAD_DATA = @"RELOAD_DATA";

@interface Pet ()

@end

@implementation Pet

@synthesize petEnergy, petLevel, doingExcercise, petName, petImageName, petType, locationLon, locationLat, location, userID;

- (instancetype) initWithDictionary:(NSDictionary *)dic
{
    //self = [NSEntityDescription insertNewObjectForEntityForName:@"Pet" inManagedObjectContext:context];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:[[DataModelManager sharedInstance] managedObjectContext]];
    
    self = [[Pet alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    if(self)
    {
        petName = [dic objectForKey:@"name"];
        petLevel = ((NSNumber*)[dic objectForKey:@"level"]).intValue;
        petType = ((NSNumber*)[dic objectForKey:@"pet_type"]).intValue;
        userID = [dic objectForKey:@"code"];
        petEnergy = [dic objectForKey:@"energy"];
        
        switch (petType) {
            case TYPE_CIERVO:
                petImageName = @"ciervo_comiendo_1";
                break;
            case TYPE_GATO:
                petImageName = @"gato_comiendo_1";
                break;
            case TYPE_JIRAFA:
                petImageName = @"jirafa_comiendo_1";
                break;
            case TYPE_LEON:
                petImageName = @"leon_comiendo_1";
                break;
                
            default:
                break;
        }

        location = [[CLLocation alloc] initWithLatitude:((NSNumber*)[dic objectForKey:@"position_lat"]).doubleValue longitude:((NSNumber*)[dic objectForKey:@"position_lon"]).doubleValue];
        locationLat = ((NSNumber*)[dic objectForKey:@"position_lat"]).intValue;
        locationLon = ((NSNumber*)[dic objectForKey:@"position_lon"]).intValue;
    }
    return self;
}


@end
