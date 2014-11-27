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

NSString* const EVENT_PATH_POST = @"/pet";
NSString* const EVENT_PATH_GET = @"/pet/em3896";

@interface NetworkAccessObject ()

@property (nonatomic, copy) Success mySuccessBlock;

@end

@implementation NetworkAccessObject

- (void) doGETPetInfo: (Success) block
{
    self.mySuccessBlock = block;
    
    [[NetworkManager sharedInstance] GET:EVENT_PATH_GET parameters:nil success:self.mySuccessBlock failure:[self getFailure]];
}

- (void) doPOSTPetLevelUp
{
    NSDictionary* petInfo = @{@"code" : @"em3896",
                              @"name" : [Pet sharedInstance].petName,
                              @"energy" : [NSNumber numberWithInt:[[Pet sharedInstance] getEnergy]],
                              @"level" : [NSNumber numberWithInt:[Pet sharedInstance].petLevel],
                              @"experience" : [NSNumber numberWithInt:[[Pet sharedInstance] getActualExp]],
                              @"pet_type" : [NSNumber numberWithInt:[Pet sharedInstance].petType]};
    
    [[NetworkManager sharedInstance] POST:EVENT_PATH_POST parameters:petInfo success:[self postSuccess] failure:[self postFailure]];
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
        else
        {
            NSLog(@"Error: %@.", status);
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

/*- (Success) getSuccess {
    return ^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        NSString* name = [responseObject objectForKey:@"name"];
        int level = ((NSNumber*)[responseObject objectForKey:@"level"]).intValue;
        int actualExp = ((NSNumber*)[responseObject objectForKey:@"experience"]).intValue;
        int energy = ((NSNumber*)[responseObject objectForKey:@"energy"]).intValue;
        
        [[Pet sharedInstance] reloadDataName:name level:level actualExp:actualExp andEnergy:energy];
    };
}*/

- (Failure) getFailure {
    return ^(NSURLSessionDataTask *task, NSError* error){
        NSLog(@"Error: %@", error.localizedDescription);
    };
}


@end
