//
//  AppConfig.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Domain
FOUNDATION_EXPORT NSString *const DevelopmentDomain;
FOUNDATION_EXPORT NSString *const ProductionDomain;

#pragma mark - Guided Tour View
FOUNDATION_EXPORT int const count_tourPages;

#pragma mark - SectionScrollView
// Section Name
FOUNDATION_EXPORT NSString *const Section00;
FOUNDATION_EXPORT NSString *const Section01;
FOUNDATION_EXPORT NSString *const Section02;
FOUNDATION_EXPORT NSString *const Section02;


#pragma mark - Gallery item width and height
static CGFloat GalleryImageWidth;
static CGFloat GalleryImageHeight;



// Don't change this
#pragma mark - CocoaLumberjack Logging Constant
#import "DDLog.h"
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif
// Add a testing color for XcodeColors
#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background
#define LogTest(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

@interface AppConfig : NSObject

+(void)setUpAppConfig;

@end
