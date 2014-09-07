//
//  AppConfig.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppConfig.h"

@implementation GCAppConfig

#pragma mark - Domain
// Change the domain for server here
NSString *const DevelopmentDomain = @"http://Story2Movie.152.23.81.41.xip.io";
NSString *const ProductionDomain = @"http://story2movie.yinanfang.webfactional.com";

#pragma mark - App General Data
@synthesize AppGeneral;
@synthesize defaultStoryCount, defaultBookCount;

#pragma mark - Book Specific
@synthesize bookCurrentPageNumber;

#pragma mark - Story Specific
@synthesize WidthForSmallStory, HeightForSmallStory, WidthForCurrentStory, HeightForCurrentStory;

#pragma mark - General
@synthesize PixelAdjustForHorizontalGap;
@synthesize HeightDeterminant_FloatVSFullScreen;
@synthesize storyDisplayStyleMode;

+ (GCAppConfig *)sharedInstance
{
    static GCAppConfig *shareInstance = nil;
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
        
        // App General Data
        defaultBookCount = [NSNumber numberWithInteger:3];
        defaultStoryCount = [NSNumber numberWithInteger:5];
//        NSDictionary *defaultAppGeneral = @{@"bookCount": defaultBookCount,
//                                            @"bookCollection":@{
//                                                    @0: @{
//                                                            @"bookName": @"s",
//                                                            @"storyCount": defaultStoryCount,
//                                                            @"storyImageNames": @"",
//                                                            },
//                                                    @1: @{
//                                                            @"bookName": @"",
//                                                            @"storyCount": defaultStoryCount,
//                                                            @"storyImageNames": @"",
//                                                            },
//                                                    @2: @{
//                                                            @"bookName": @"",
//                                                            @"storyCount": defaultStoryCount,
//                                                            @"storyImageNames": @"",
//                                                            },
//                                                    }
//                                            };
//        AppGeneral = [defaultAppGeneral mutableCopy];
        NSMutableDictionary *storyImageNames = [[NSMutableDictionary alloc] init];
        NSDictionary *singleBook = @{
                                     @"bookName": @"defaultName",
                                     @"storyCount": defaultStoryCount,
                                     @"storyImageNames": [storyImageNames mutableCopy],
                                     };
        NSDictionary *bookCollection = @{
                                         @"0": [singleBook mutableCopy],
                                         @"1": [singleBook mutableCopy],
                                         @"2": [singleBook mutableCopy],
                                         };
        NSDictionary *data_tmp = @{
                                   @"bookCount": defaultBookCount,
                                   @"bookCollection": [bookCollection mutableCopy],
                                   };
        AppGeneral = [data_tmp mutableCopy];
        
        // Book Specific
        bookCurrentPageNumber = 0;
        
        // Story Specific
        if (IS_IPHONE5S) {
            HeightForSmallStory = 258;
        }else if (IS_IPHONE4S){
            HeightForSmallStory = 218;                                          // 480*(258/568) = 218.028169
        }
        WidthForSmallStory = 320*(HeightForSmallStory/ScreenHeight);           // 145.352113
        
        HeightForCurrentStory = HeightForSmallStory;
        WidthForCurrentStory = WidthForSmallStory;
        
        // General
        PixelAdjustForHorizontalGap = 1.0;
        HeightDeterminant_FloatVSFullScreen = ScreenHeight-(ScreenHeight-HeightForSmallStory)/2;
        storyDisplayStyleMode = StoryDisplayStyleModeFloat;

        
    }
    return self;
}

@end
