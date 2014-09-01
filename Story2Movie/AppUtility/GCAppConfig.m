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
NSString *const DevelopmentDomain = @"http://Story2Movie.192.168.0.7.xip.io";
NSString *const ProductionDomain = @"http://story2movie.yinanfang.webfactional.com";

#pragma mark - App General Data
@synthesize AppGeneral;
@synthesize defaultStoryCount, defaultBookCount;

#pragma mark - Book
@synthesize bookCurrentPageNumber;

#pragma mark - Story item
@synthesize NSScreenSizeWithInset, StoryImageWidth, StoryImageHeight;

+ (AppConfig *)sharedInstance
{
    static AppConfig *shareInstance = nil;
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
        //        AppGeneral = [[NSMutableDictionary alloc] init];
        //        NSInteger defaultBookCount = 3;
        //        [AppGeneral setObject:[NSNumber numberWithInteger:defaultBookCount] forKey:@"bookCount"];
        //        NSMutableDictionary *bookDictionaryCollection = [[NSMutableDictionary alloc] init];
        //        [AppGeneral setObject:bookDictionaryCollection forKey:@"book"];
        //        NSMutableDictionary *bookDictionarySingle;
        //        for (NSInteger i = 0; i < defaultBookCount; i++) {
        //            <#statements#>
        //        }
        defaultBookCount = [NSNumber numberWithInteger:3];
        defaultStoryCount = [NSNumber numberWithInteger:5];
        NSDictionary *defaultAppGeneral = @{@"bookCount": defaultBookCount,
                                            @"bookCollection":@{
                                                    @0: @{
                                                            @"bookName": @"s",
                                                            @"storyCount": defaultStoryCount,
                                                            @"storyImageNames": @"",
                                                            },
                                                    @1: @{
                                                            @"bookName": @"",
                                                            @"storyCount": defaultStoryCount,
                                                            @"storyImageNames": @"",
                                                            },
                                                    @2: @{
                                                            @"bookName": @"",
                                                            @"storyCount": defaultStoryCount,
                                                            @"storyImageNames": @"",
                                                            },
                                                    }
                                            };
        AppGeneral = [defaultAppGeneral mutableCopy];
        
        
        bookCurrentPageNumber = 0;
        
        // Set up the GalleryImageWidth and GalleryImageHeight according to device height
        NSScreenSizeWithInset = [NSValue valueWithCGSize:CGSizeMake(ScreenWidth-2, ScreenHeight-2)];
        
        if (IS_IPHONE4S) {
            StoryImageHeight = 215;
        }else if (IS_IPHONE5S){
            StoryImageHeight = 258;
        }
        StoryImageWidth = 320*(StoryImageHeight/ScreenHeight);
        
        
        
        
        
        
    }
    return self;
}

@end
