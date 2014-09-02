//
//  GCStoryScrollView.h
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCStoryController;
#import "GCStoryItemView.h"

@interface GCStoryScrollView : UIScrollView <UIScrollViewDelegate>

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCStoryController *parentController;

#pragma mark - Story View
@property AFHTTPRequestOperationManager *manager;
@property NSInteger storyScrollerNumber, storyCount, StoryImageHeight, StoryImageWidth;
@property NSMutableArray *storyNames, *storyImageViews;
@property GCStoryItemView *previousStoryImageView;
@property MASConstraint *storyImageRightMostConstraint;

-(id)initWithParentController:(GCStoryController *)controller ScrollerNumber:(NSInteger)ScrollerNumber;
-(void)setupBlankStoryScrollView;
-(void)loadStoryScrollViewContent;



-(void)moveStoryScrollViewToMiddel;
-(void)moveStoryScrollViewToRight;
-(void)moveStoryScrollViewToLeft;

@end
