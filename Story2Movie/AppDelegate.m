//
//  AppDelegate.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize utility;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize Utility object
    utility = [[AppUtility alloc] init];
    [utility ApplicationSetupWithProductionMode:NO];
    
    // Initialize window and set background
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    // Check First Launch
    [utility setHasShownTour:NO];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:HasShownTour])
    {
        DDLogVerbose(@"It's NOT First Launch. Presenting Gallery...");
        // Set root view controller
        self.window.rootViewController = [[GalleryViewController alloc] init];
    }else{
        DDLogVerbose(@"It's First Launch. Presenting Guided Tour...");
        // Set the First Launch BOOL
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HasShownTour];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // Set root view controller
        self.window.rootViewController = [[GuidedTourViewController alloc] init];
    }
    
    // Display view
    [self.window makeKeyAndVisible];
    DDLogInfo(@"========== End of AppDelegate ==========");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
