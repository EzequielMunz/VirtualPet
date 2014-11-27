//
//  NetworkManager.m
//  VirtualPet
//
//  Created by Ezequiel on 11/26/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"

NSString* const SESSION_URL = @"http://tamagotchi.herokuapp.com";

@interface NetworkManager ()

@end

@implementation NetworkManager

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static NetworkManager* _sharedObject;
    
    dispatch_once(&pred, ^{
        // Indicator Manager Setup
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //sessionConfiguration.HTTPAdditionalHeaders = [NetworkManager getAdditionalHeaders];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10*1024*1024 diskCapacity:50*1024*1024 diskPath:nil];
        
        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        sessionConfiguration.timeoutIntervalForRequest = 20.0f;
        
        _sharedObject = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:SESSION_URL] sessionConfiguration:sessionConfiguration];
        
        _sharedObject.requestSerializer = [AFJSONRequestSerializer serializer];
        
    });
    
    return _sharedObject;
}


@end
