//
//  NetworkTest.m
//  VirtualPet
//
//  Created by Ezequiel on 11/26/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "NetworkTest.h"
#import "NetworkManager.h"

NSString* const EVENT_PATH = @"/key/value/one/two";

@implementation NetworkTest

- (void) doGETandParseInfo
{
    [[NetworkManager sharedInstance] GET:EVENT_PATH parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        NSLog([NSString stringWithFormat:@"JSON: %@", responseObject ]);
        
        
    }failure:^(NSURLSessionDataTask *task, NSError* error){
        NSLog([NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
        
        
    }];
}

@end
