//
//  AppConfig.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// Change the domain for server here
#define DevelopmentDomain @"http://story2movie.192.168.0.10.xip.io"
#define ProductionDomain @"http://story2movie.yinanfang.webfactional.com"

// Section Name
#define Section00 @"00_Story"
#define Section01 @"01_Video"
#define Section02 @"02_Event"
#define Section03 @"03_About"

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

@end
