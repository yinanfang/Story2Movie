//
//  AppConfig.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppConfig.h"

@implementation AppConfig

#pragma mark - Domain
// Change the domain for server here
NSString *const DevelopmentDomain = @"http://story2movie.192.168.0.10.xip.io";
NSString *const ProductionDomain = @"http://story2movie.yinanfang.webfactional.com";

#pragma mark - Section Name
NSString *const Section00 = @"00_Story";
NSString *const Section01 = @"01_Video";
NSString *const Section02 = @"02_About";

#pragma mark - GCBookScrollView
@synthesize bookCount, bookCurrentPageNumber;

#pragma mark - Story item
@synthesize NSScreenSizeWithInset, StoryImageWidth, StoryImageHeight;

+ (AppConfig *)sharedInstance
{
    static AppConfig *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init
{
    DDLogVerbose(@"Initializing App Configuration...");
    self = [super init];
    if (self) {
        // Initialize values
        bookCount = 3;
        bookCurrentPageNumber = 0;
        
        // Set up the GalleryImageWidth and GalleryImageHeight according to device height
        NSScreenSizeWithInset = [NSValue valueWithCGSize:CGSizeMake(ScreenWidth-2, ScreenHeight-2)];
        
        if (IS_IPHONE4S) {
            StoryImageHeight = 215;
        }else if (IS_IPHONE5S){
            StoryImageHeight = 258;
        }
        StoryImageWidth = 320*(StoryImageHeight/ScreenHeight);
    }
    return self;
}

@end
