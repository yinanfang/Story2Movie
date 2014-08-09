//
//  AppUtility.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppUtility.h"

@implementation GCAppUtility

#pragma mark - Basic Setup
-(void)ApplicationSetupWithProductionMode:(BOOL)mode
{
    [self setupLogging];
    DDLogInfo(@"====================  Application Setup Started  ====================");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (mode) {
        DDLogInfo(@"In PRODUCTION mode with domain: %@", ProductionDomain);
        [defaults setObject:ProductionDomain forKey:@"current_domain"];
    }else {
        DDLogInfo(@"In Development mode with domain: %@", DevelopmentDomain);
        [defaults setObject:DevelopmentDomain forKey:@"current_domain"];
    }
    [AppConfig setUpAppConfig];
    [Constant setUpConstant];
}

-(void)setCachePolicy
{
    // Disable Cache for the networking methods
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

- (void)setupLogging
{
    // DDTTYLogger
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // And then enable colors
    // Add Environment Variable in "Edit scheme": XcodeColors YES
    // Follow the Issue Report: https://github.com/CocoaLumberjack/CocoaLumberjack/issues/50#issuecomment-34286656
    // Enables XcodeColors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    // Set logger color
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor purpleColor] backgroundColor:nil forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blackColor] backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor grayColor] backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
    // Test logger color
    DDLogError(@"DDLogError");
    DDLogWarn(@"DDLogWarn");
    DDLogInfo(@"DDLogInfo");
    DDLogDebug(@"DDLogDebug");
    DDLogVerbose(@"DDLogVerbose");
    LogTest(@"LogTest for XcodeColors");
    
    // DDASLLogger
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    [fileLogger setRollingFrequency:60 * 60 * 24];   // roll every day
    [fileLogger setMaximumFileSize:1024 * 1024 * 2]; // max 2mb file size
    [fileLogger.logFileManager setMaximumNumberOfLogFiles:7];
    [fileLogger setLogFormatter:[[CustomLogFormatters alloc] init]];
    
    [DDLog addLogger:fileLogger];
    DDLogInfo(@"Logging is setup (\"%@\")", [fileLogger.logFileManager logsDirectory]);
    
}

-(NSString *)getCurrentDomain
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *current_domain = [defaults objectForKey:@"current_domain"];
    return current_domain;
}

#pragma mark - Others
-(UIColor *)colorWithRGBAinHex:(NSUInteger)color
{
    DDLogVerbose(@"... Invoked UtilityClass.colorWithRGBAinHex ...");
    
    return [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f
                           green:((color >> 16) & 0xFF) / 255.0f
                            blue:((color >> 8) & 0xFF) / 255.0f
                           alpha:((color) & 0xFF) / 255.0f];
}

-(CGFloat)getStatusAndNavBarSize:(UIViewController *)controller {
    DDLogVerbose(@"... Invoked UtilityClass.getStatusAndNavBarSize ...");
    
    CGFloat statusBarHeight = 0.000000;
    CGFloat navBarHeight = 0.000000;
    UIInterfaceOrientation orientation_StatusBar = [[UIApplication sharedApplication] statusBarOrientation];
    
    switch (orientation_StatusBar) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            DDLogVerbose(@"It's UIInterfaceOrientationPortrait");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            navBarHeight = controller.navigationController.navigationBar.frame.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            DDLogVerbose(@"It's UIInterfaceOrientationLandscape");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.width;
            navBarHeight = controller.navigationController.navigationBar.frame.size.height;
            break;
        default:
            break;
    }
    return statusBarHeight + navBarHeight;
}

-(CGRect)getAvailableFrameUnderNavView:(UIViewController *)controller
{
    DDLogVerbose(@"... Invoked UtilityClass.getAvailableFrameUnderNavView ...");
    
    CGFloat StatusAndNavBarSize = [self getStatusAndNavBarSize:controller];
    CGRect currentFrame = [controller.view frame];
    UIInterfaceOrientation orientation_StatusBar = [[UIApplication sharedApplication] statusBarOrientation];
    
    switch (orientation_StatusBar) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            DDLogVerbose(@"Original frame: %@", [NSValue valueWithCGRect:currentFrame]);
            currentFrame = CGRectMake(controller.view.frame.origin.x, controller.view.frame.origin.y + StatusAndNavBarSize, controller.view.frame.size.width, controller.view.frame.size.height - StatusAndNavBarSize);
            DDLogVerbose(@"Adjusted frame: %@", [NSValue valueWithCGRect:currentFrame]);
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            DDLogVerbose(@"Original frame: %@", [NSValue valueWithCGRect:currentFrame]);
            currentFrame = CGRectMake(controller.view.frame.origin.x, controller.view.frame.origin.y + StatusAndNavBarSize, controller.view.frame.size.width, controller.view.frame.size.height - StatusAndNavBarSize);
            DDLogVerbose(@"Adjusted frame: %@", [NSValue valueWithCGRect:currentFrame]);
            break;
        default:
            break;
    }
    return currentFrame;
}

-(CGRect)getAvailableFrameUnderNormalView:(UIViewController *)controller
{
    DDLogVerbose(@"... Invoked UtilityClass.getAvailableFrameUnderNormalView ...");
    
    CGRect currentFrame = [controller.view frame];
    UIInterfaceOrientation orientation_StatusBar = [[UIApplication sharedApplication] statusBarOrientation];
    
    switch (orientation_StatusBar) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            DDLogVerbose(@"Original frame: %@", [NSValue valueWithCGRect:currentFrame]);
            currentFrame = CGRectMake(controller.view.frame.origin.x, controller.view.frame.origin.y, controller.view.frame.size.width, controller.view.frame.size.height);
            DDLogVerbose(@"Adjusted frame: %@", [NSValue valueWithCGRect:currentFrame]);
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            DDLogVerbose(@"Original frame: %@", [NSValue valueWithCGRect:currentFrame]);
            currentFrame = CGRectMake(controller.view.frame.origin.x, controller.view.frame.origin.y, controller.view.frame.size.width, controller.view.frame.size.height);
            DDLogVerbose(@"Adjusted frame: %@", [NSValue valueWithCGRect:currentFrame]);
            break;
        default:
            break;
    }
    return currentFrame;
}

-(void)addTitleinForNavViewWithString:(NSString *)str Font:(NSString *)font Size:(float)size Color:(UIColor *)color viewController:(UIViewController *)controller
{
    DDLogVerbose(@"... Invoked UtilityClass.addTitleinForNavViewWithString ...");
    
    DDLogVerbose(@"in add title method");
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [title setText:str];
    [title setFont:[UIFont fontWithName:font size:size]];
    [title setTextColor:color];
    controller.navigationItem.titleView = title;
}

-(void)setHasShownTour:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:HasShownTour];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(UIImageView *)getFullScreenImageView:(NSString *)name
{
    UIImage *image;
    if (IS_IPHONE4S) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@@2x.png", name]];
    }else if (IS_IPHONE5S){
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@@R4.png", name]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}










@end
