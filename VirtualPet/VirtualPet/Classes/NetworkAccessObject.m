//
//  NerworkAccessObject.m
//  VirtualPet
//
//  Created by Ezequiel on 11/26/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "NetworkAccessObject.h"
#import "NetworkManager.h"
#import "MyPet.h"

NSString* const EVENT_PATH_POST = @"/pet";
NSString* const EVENT_PATH_GET = @"/pet/em3896";
NSString* const EVENT_PATH_GET_BY_CODE = @"/pet/";
NSString* const EVENT_PATH_GET_LIST = @"/pet/all";
NSString* const CODE_IDENTIFIER = @"em3896";

@interface NetworkAccessObject ()

@property (nonatomic, copy) Success mySuccessBlock;
@property (nonatomic, weak) NSURLSessionDataTask* runningTask;

@end

@implementation NetworkAccessObject

- (void) doGETPetInfo: (Success) block
{
    self.mySuccessBlock = block;
    
    [[NetworkManager sharedInstance] GET:EVENT_PATH_GET parameters:nil success:self.mySuccessBlock failure:[self getFailure]];
}

- (void) doGETPetInfoByCode: (NSString*) code withBlock: (Success) block
{
    NSString* path = [NSString stringWithFormat:@"%@%@", EVENT_PATH_GET_BY_CODE, code];
    NSLog(@"Path: %@", path);
    [[NetworkManager sharedInstance] GET:path parameters:nil success:block failure:[self getFailure]];
}

- (void) doPOSTPetUpdate
{
    NSDictionary* petInfo = @{@"code" : @"em3896",
                              @"name" : [MyPet sharedInstance].petName,
                              @"energy" : [NSNumber numberWithInt:[[MyPet sharedInstance] getEnergy]],
                              @"level" : [NSNumber numberWithInt:[MyPet sharedInstance].petLevel],
                              @"experience" : [NSNumber numberWithInt:[[MyPet sharedInstance] getActualExp]],
                              @"pet_type" : [NSNumber numberWithInt:[MyPet sharedInstance].petType],
                              @"position_lat" : [NSNumber numberWithFloat:[MyPet sharedInstance].location.coordinate.latitude],
                              @"position_lon" : [NSNumber numberWithFloat:[MyPet sharedInstance].location.coordinate.longitude]};
    
    [[NetworkManager sharedInstance] POST:EVENT_PATH_POST parameters:petInfo success:[self postSuccess] failure:[self postFailure]];
}

- (void) doGETPetList: (Success) block
{
    self.runningTask = [[NetworkManager sharedInstance] GET:EVENT_PATH_GET_LIST parameters:nil success:block failure:[self getFailure]];
}

- (void) cancelCurrentTask {
    [self.runningTask cancel];
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
