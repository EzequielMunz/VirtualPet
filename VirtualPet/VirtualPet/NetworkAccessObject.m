//
//  NerworkAccessObject.m
//  VirtualPet
//
//  Created by Ezequiel on 11/26/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "NetworkAccessObject.h"
#import "NetworkManager.h"
#import "Pet.h"

NSString* const EVENT_PATH = @"/pet";

@implementation NetworkAccessObject

- (void) doGET
{
    [[NetworkManager sharedInstance] GET:EVENT_PATH parameters:nil success:[self getSuccess] failure:[self getFailure]];
}

- (void) doPOSTPetLevelUp
{
    NSDictionary* petInfo = @{@"code" : @"em3896",
                              @"name" : [Pet sharedInstance].petName,
                              @"energy" : [NSNumber numberWithInt:[[Pet sharedInstance] getEnergy]],
                              @"level" : [NSNumber numberWithInt:[Pet sharedInstance].petLevel],
                              @"experience" : [NSNumber numberWithInt:[[Pet sharedInstance] getActualExp]]};
    
    [[NetworkManager sharedInstance] POST:EVENT_PATH parameters:petInfo success:[self postSuccess] failure:[self postFailure]];
}

//*************************************************************
// POST Blocks
//*************************************************************

- (Success) postSuccess {
    return ^(NSURLSessionDataTask *task, id responseObject){
        
        NSString* status = [responseObject objectForKey:@"status"];
        
        if([status isEqualToString:@"ok"])
        {
            NSLog(@"JSON : %@", responseObject);
        }
    };
}

- (Failure) postFailure {
    return ^(NSURLSessionDataTask *task, NSError* error){
        NSLog(@"Error : %@", error.localizedDescription);
    };
}

//*************************************************************
// GET Blocks
//*************************************************************

- (Success) getSuccess {
    return ^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
    };
}

- (Failure) getFailure {
    return ^(NSURLSessionDataTask *task, NSError* error){
        NSLog(@"Error: %@", error.localizedDescription);
    };
}


@end
