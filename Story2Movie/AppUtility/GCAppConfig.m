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

#pragma mark - Guided Tour View
int const count_tourPages = 3;

#pragma mark - SectionScrollView
NSString *const Section00 = @"00_Story";
NSString *const Section01 = @"01_Video";
NSString *const Section02 = @"02_Event";
NSString *const Section03 = @"03_About";

+(void)setUpAppConfig
{
    DDLogVerbose(@"Initializing App Configuration...");
    
    // Set up the GalleryImageWidth and GalleryImageHeight according to device height
    NSScreenSizeWithInset = [NSValue valueWithCGSize:CGSizeMake(ScreenWidth-2, ScreenHeight-2)];
    
    GalleryImageWidth = 145;
    if (IS_IPHONE4S) {
        GalleryImageHeight = 215;
    }else if (IS_IPHONE5S){
        GalleryImageHeight = 258;
    }
    
    
}

@end
