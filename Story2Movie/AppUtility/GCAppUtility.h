//
//  AppUtility.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// AppUtility
#import "GCAppConfig.h"
#import "GCConstant.h"

// AFNetworking
#import <AFNetworking.h>
// CocoaLumberjack
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <DDTTYLogger.h>
#import <DDASLLogger.h>
#import <DDFileLogger.h>
#import "GCCustomLogFormatters.h"
// facebook-ios-sdk
#import <FacebookSDK/FacebookSDK.h>
// FlatUIKit
#import <FlatUIKit/FlatUIKit.h>
// LBBlurredImage
#import <FXBlurView/FXBlurView.h>
// Mantle
#import <Mantle/Mantle.h>
// Masonry
#import <Masonry.h>
// TSMessage
#import <TSMessages/TSMessage.h>
// POP
#import <pop/POP.h>
// ReactiveCocoa
#import <ReactiveCocoa/ReactiveCocoa.h>
// Shimmer
#import <Shimmer/FBShimmeringView.h>
// Tweaks
#import <Tweaks/FBTweak.h>

@interface GCAppUtility : NSObject

// This is the method to access this Singleton class
+ (GCAppUtility *)sharedInstance;

#pragma mark - Basic Setup
-(void)ApplicationSetupWithProductionMode:(BOOL)mode;
-(NSString *)getCurrentDomain;

#pragma mark - Others
-(UIColor *)colorWithRGBAinHex:(NSUInteger)color;
-(CGFloat)getStatusAndNavBarSize:(UIViewController *)controller;
-(CGRect)getAvailableFrameUnderNavView:(UIViewController *)controller;
-(CGRect)getAvailableFrameUnderNormalView:(UIViewController *)controller;
-(void)addTitleinForNavViewWithString:(NSString *)str Font:(NSString *)font Size:(float)size Color:(UIColor *)color viewController:(UIViewController *)controller;
-(void)setHasShownTour:(BOOL)mode;
-(UIImageView *)getFullScreenImageView:(NSString *)name;

@end
