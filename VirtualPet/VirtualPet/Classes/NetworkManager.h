//
//  NetworkManager.h
//  VirtualPet
//
//  Created by Ezequiel on 11/26/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype) sharedInstance;

@end
