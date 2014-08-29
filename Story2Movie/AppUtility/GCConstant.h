//
//  Constant.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Device Type
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE5S ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4S ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

typedef NS_ENUM(NSInteger, testEnum) {
    testEnum1,
    testEnum2,
    testEnum3,
    testEnum4
};

@interface Constant : NSObject

#pragma mark - Screen width and height
// iPhone4S@2x: W*H = 320*480
// iPhone5S@R4: W*H = 320*568
#define ScreenBounds [[UIScreen mainScreen] bounds]
#define ScreenSize [[UIScreen mainScreen] bounds].size
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#pragma mark - Gesture Recognizer
FOUNDATION_EXPORT CGFloat const SWIPE_VELOCITY_THRESHOLD;

#pragma mark - Others
FOUNDATION_EXPORT NSString *const HasShownTour;

// This is the method to access this Singleton class
+ (AppConfig *)sharedInstance;

@end
