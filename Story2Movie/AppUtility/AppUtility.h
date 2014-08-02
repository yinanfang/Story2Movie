//
//  AppUtility.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// AppUtility
#import "AppConfig.h"
#import "Constant.h"

// CocoaLumberjack
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "DDASLLogger.h"
#import "DDFileLogger.h"
#import "CustomLogFormatters.h"

//AFNetworking
#import "AFNetworking.h"

@interface AppUtility : NSObject

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

@end
