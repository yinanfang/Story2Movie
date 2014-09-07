//
//  GCStoryScrollView.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCStoryCollectionController.h"
#import "GCStoryScrollView.h"

@implementation GCStoryScrollView
@synthesize utility;
@synthesize parentController;
@synthesize WidthForSmallStory, HeightForSmallStory;
@synthesize storyScrollViewNumber, storyCount;
@synthesize storyControllerArray;

#pragma mark - Blank Frame Initialization
- (id)initWithParentController:(GCStoryCollectionController *)controller ScrollViewNumber:(NSInteger)number
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        storyScrollViewNumber = number;
        storyCount = [[[GCAppConfig sharedInstance] defaultStoryCount] integerValue];
        storyControllerArray = [[NSMutableArray alloc] init];
        WidthForSmallStory = [[GCAppConfig sharedInstance] WidthForSmallStory];
        HeightForSmallStory = [[GCAppConfig sharedInstance] HeightForSmallStory];
        
        // Empty Frame Initialization
        self.pagingEnabled = NO;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.backgroundColor = [UIColor clearColor];
        // Only place the first scroll view in the middle
        if (storyScrollViewNumber == 0) {
            self.frame = CGRectMake(0, 0, ScreenWidth, HeightForSmallStory);
        }else {
            self.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, HeightForSmallStory);
        }
        [parentController.view addSubview:self];
        // Add story controller after adding the story scroll view
        for (int storyNumber = 0; storyNumber < storyCount; storyNumber++) {
            GCStoryController *storyController = [[GCStoryController alloc] initWithFrame:CGRectMake(WidthForSmallStory*storyNumber, 0, WidthForSmallStory, HeightForSmallStory) ParentView:self StoryNumber:storyNumber];
            [parentController addChildViewController:storyController];
            [self addSubview:storyController.view];
            [storyController didMoveToParentViewController:parentController];
            [storyControllerArray insertObject:storyController atIndex:storyNumber];
        }
        self.contentSize = CGSizeMake(WidthForSmallStory*storyCount, WidthForSmallStory);
    }
    return self;
}

- (void)loadStoryScrollViewContent
{
    DDLogWarn(@"Start loading Story Controller #%li in Story Scroll View...", storyScrollViewNumber);
    // Add Story Controller if new story count is different
    NSInteger defaultStoryCount = storyCount;
    NSString *keyPathForStoryCountInAppGeneral = [NSString stringWithFormat:@"bookCollection.%li.storyCount", storyScrollViewNumber];
    storyCount = [[[[GCAppConfig sharedInstance] AppGeneral] valueForKeyPath:keyPathForStoryCountInAppGeneral] integerValue];
    if (storyCount != defaultStoryCount) {
        DDLogWarn(@"adding more Story Controller...");
        for (int storyNumber = (int)defaultStoryCount; storyNumber < storyCount; storyNumber++) {
            GCStoryController *storyController = [[GCStoryController alloc] initWithFrame:CGRectMake(WidthForSmallStory*storyNumber, 0, WidthForSmallStory, HeightForSmallStory) ParentView:self StoryNumber:storyNumber];
            [parentController addChildViewController:storyController];
            [self addSubview:storyController.view];
            [storyController didMoveToParentViewController:parentController];
            [storyControllerArray insertObject:storyController atIndex:storyNumber];
        }
        self.contentSize = CGSizeMake(WidthForSmallStory*storyCount, HeightForSmallStory);
        DDLogWarn(@"Loop through and call load method in Story Controller");
    }
    for (GCStoryController *storyController in storyControllerArray) {
        [storyController.storyView loadStoryContent];
    }
}


#pragma mark - Story Scroll View Movement
-(void)moveStoryScrollViewToMiddel
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnimation.springBounciness=0;
    springAnimation.springSpeed=20;
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, ScreenWidth, HeightForSmallStory)];
    [self pop_addAnimation:springAnimation forKey:@"moveStoryScrollViewToMiddel"];
}

-(void)moveStoryScrollViewToRight
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnimation.springBounciness=0;
    springAnimation.springSpeed=20;
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(ScreenWidth, 0, ScreenWidth, HeightForSmallStory)];
    [self pop_addAnimation:springAnimation forKey:@"moveStoryScrollViewToMiddel"];
}

-(void)moveStoryScrollViewToLeft
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnimation.springBounciness=0;
    springAnimation.springSpeed=20;
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(-ScreenWidth, 0, ScreenWidth, HeightForSmallStory)];
    [self pop_addAnimation:springAnimation forKey:@"moveStoryScrollViewToMiddel"];

}

@end
