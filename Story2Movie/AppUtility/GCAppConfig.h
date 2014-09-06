//
//  AppConfig.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// Don't change this
#pragma mark - CocoaLumberjack Logging Constant
#import <CocoaLumberjack/CocoaLumberjack.h>
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
#define DDLogTest(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

@interface GCAppConfig : NSObject

#pragma mark - Domain
FOUNDATION_EXPORT NSString *const DevelopmentDomain;
FOUNDATION_EXPORT NSString *const ProductionDomain;

#pragma mark - App General Data
@property NSMutableDictionary *AppGeneral;
@property NSNumber *defaultStoryCount, *defaultBookCount;

#pragma mark - Book
@property NSMutableDictionary *bookNames;
@property NSInteger bookCurrentPageNumber;

#pragma mark - Story
@property NSValue *NSScreenSizeWithInset;
@property CGFloat StoryImageWidth, StoryImageHeight;
@property CGFloat StoryImageWidth_Standard, StoryImageHeight_Standard;
@property CGFloat HeightDeterminant_FloatVSFullScreen;


typedef NS_ENUM(NSInteger, StoryScrollViewPositionMode) {
    StoryScrollViewPositionFloat,
    StoryScrollViewPositionFullScreen
};
@property StoryScrollViewPositionMode storyScrollViewPositionMode;

// This is the method to access this Singleton class
+ (GCAppConfig *)sharedInstance;


@end
