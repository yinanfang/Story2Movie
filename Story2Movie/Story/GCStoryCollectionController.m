//
//  GCStoryCollectionController.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookCollectionController.h"
#import "GCStoryCollectionController.h"

@interface GCStoryCollectionController ()

@end

@implementation GCStoryCollectionController
@synthesize utility;
@synthesize parentController;
@synthesize bookCount;
@synthesize storyScrollViewArray;

- (id)initWithParentController:(GCBookCollectionController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        bookCount = [[[GCAppConfig sharedInstance] defaultBookCount] integerValue];
        
        // Empty Frame Initialization
        self.view.frame = [[GCAppConfig sharedInstance] BoundsForStoryCollectionController];
        self.view.backgroundColor = [UIColor clearColor];
        storyScrollViewArray = [[NSMutableArray alloc] init];
        for (int scrollViewNumber = 0; scrollViewNumber < bookCount; scrollViewNumber++) {
            GCStoryScrollView *storyScrollView = [[GCStoryScrollView alloc] initWithParentController:self ScrollViewNumber:scrollViewNumber];
            [storyScrollViewArray insertObject:storyScrollView atIndex:scrollViewNumber];
        }
        
        
    }
    return self;
}

- (void)loadStoryCollectionControllerContent
{
    DDLogWarn(@"Start loading Story Scroll View in Story Collection Controller...");
    // Add book image view if new book count is different
    NSInteger defaultBookCount = bookCount;
    NSString *keyPathForBookCountInAppGeneral = [NSString stringWithFormat:@"bookCount"];
    bookCount = [[[[GCAppConfig sharedInstance] AppGeneral] objectForKey:keyPathForBookCountInAppGeneral] integerValue];
    if (bookCount != defaultBookCount) {
        DDLogWarn(@"adding more Story Scroll Views");
        for (int scrollViewNumber = (int)defaultBookCount; scrollViewNumber < bookCount; scrollViewNumber++) {
            GCStoryScrollView *storyScrollView = [[GCStoryScrollView alloc] initWithParentController:self ScrollViewNumber:scrollViewNumber];
            [storyScrollViewArray insertObject:storyScrollView atIndex:scrollViewNumber];
        }
        DDLogWarn(@"Loop through and call load method in image views");
        for (GCStoryScrollView *storyScrollView in storyScrollViewArray) {
            [storyScrollView loadStoryScrollViewContent];
        }
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
