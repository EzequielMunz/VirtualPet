//
//  NSTimer+TimerWithAutoInvalidate.m
//  VirtualPet
//
//  Created by Ezequiel on 11/25/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "NSTimer+TimerWithAutoInvalidate.h"

@implementation NSTimer (NSTimerWithAutoInvalidate)

- (void) autoInvalidate
{
    if(self && [self isValid])
    {
        [self invalidate];
    }
}

@end
