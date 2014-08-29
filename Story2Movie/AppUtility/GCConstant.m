//
//  Constant.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCConstant.h"

@implementation Constant

#pragma mark - Gesture Recognizer
CGFloat const SWIPE_VELOCITY_THRESHOLD = 0.278f;

#pragma mark - Others
NSString *const HasShownTour = @"HasShownTour";


+ (Constant *)sharedInstance
{
    static Constant *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init
{
    DDLogVerbose(@"Initializing Constant...");
    self = [super init];
    if (self) {
        // Initialize values
        
    }
    return self;
}

@end
