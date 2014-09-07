//
//  GCStoryView.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCStoryScrollView.h"
#import "GCStoryController.h"
#import "GCStoryView.h"

@implementation GCStoryView
@synthesize utility;
@synthesize parentController;
@synthesize WidthForSmallStory, HeightForSmallStory;
@synthesize PixelAdjustForHorizontalGap;
@synthesize manager;

- (id)initWithParentController:(GCStoryController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        WidthForSmallStory = [[GCAppConfig sharedInstance] WidthForSmallStory];
        HeightForSmallStory = [[GCAppConfig sharedInstance] HeightForSmallStory];
        PixelAdjustForHorizontalGap = [[GCAppConfig sharedInstance] PixelAdjustForHorizontalGap];
        manager = [AFHTTPRequestOperationManager manager];
        
        // Empty Frame Initialization
        self.frame = CGRectMake(PixelAdjustForHorizontalGap, 0, WidthForSmallStory-PixelAdjustForHorizontalGap*2, HeightForSmallStory);;
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        [parentController.view addSubview:self];
    }
    return self;
    
}

- (void)loadStoryContent
{
    // Update story image
    NSString *imageKeyPath = [NSString stringWithFormat:@"bookCollection.%li.storyImageNames.%li", parentController.parentView.storyScrollViewNumber, parentController.storyNumber];
    NSString *storyImageName = [[[GCAppConfig sharedInstance] AppGeneral] valueForKeyPath:imageKeyPath];
    NSString *url_string = [[NSString alloc] initWithFormat:@"%@/app_content/book/%li/story/%@%@", [utility getCurrentDomain], parentController.parentView.storyScrollViewNumber, storyImageName, [[GCConstant sharedInstance] PNGTypeAndSuffix]];
    DDLogVerbose(@"url: %@", url_string);
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage *responsePNG) {
        DDLogVerbose(@"Retrieve story image: %@", responsePNG);
        // Change book view background color
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *storyImage = [[UIImageView alloc] initWithFrame:self.frame];
        storyImage.image = responsePNG;
        [self addSubview:storyImage];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Error: %@", error);
    }];

    
}









@end
