//
//  Pet.m
//  VirtualPet
//
//  Created by Ezequiel on 11/21/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "Pet.h"

NSString* const EVENT_UPDATE_ENERGY = @"UPDATE_ENERGY";
NSString* const EVENT_SET_EXHAUST = @"SET_EXHAUST";
NSString* const EVENT_LEVEL_UP = @"LEVEL_UP";
NSString* const EVENT_UPDATE_EXPERIENCE = @"UPDATE_EXPERIENCE";
NSString* const EVENT_RELOAD_DATA = @"RELOAD_DATA";

@interface Pet ()

@end

@implementation Pet

- (instancetype) initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if(self)
    {
        self.petName = [dic objectForKey:@"name"];
        self.petLevel = ((NSNumber*)[dic objectForKey:@"level"]).intValue;
        self.petType = ((NSNumber*)[dic objectForKey:@"pet_type"]).intValue;
        self.userID = [dic objectForKey:@"code"];
        
        switch (self.petType) {
            case TYPE_CIERVO:
                self.petImageName = @"ciervo_comiendo_1";
                break;
            case TYPE_GATO:
                self.petImageName = @"gato_comiendo_1";
                break;
            case TYPE_JIRAFA:
                self.petImageName = @"jirafa_comiendo_1";
                break;
            case TYPE_LEON:
                self.petImageName = @"leon_comiendo_1";
                break;
                
            default:
                break;
        }

        self.location = [[CLLocation alloc] initWithLatitude:((NSNumber*)[dic objectForKey:@"position_lat"]).doubleValue longitude:((NSNumber*)[dic objectForKey:@"position_lon"]).doubleValue];
    }
    return self;
}


@end
