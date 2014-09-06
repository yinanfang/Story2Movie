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

@interface GCStoryScrollView : UIScrollView <UIScrollViewDelegate, UIGestureRecognizerDelegate>

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCStoryController *parentController;

#pragma mark - Story View
@property AFHTTPRequestOperationManager *manager;
@property NSInteger storyScrollerNumber, storyCount;
@property CGFloat StoryImageHeight, StoryImageWidth;
@property CGFloat StoryImageWidth_Standard, StoryImageHeight_Standard;
@property NSMutableArray *storyNames, *storyItemViews;
@property GCStoryItemView *previousStoryImageView;
@property MASConstraint *storyImageRightMostConstraint;
@property UIPanGestureRecognizer *storyScrollViewVerticalPanGesture;
@property CGPoint storyScrollViewPanVelecity, storyScrollViewPanTranslation;
@property CGPoint oldContentOffset;
@property CGRect oldStoryControllerViewFrame;

@property StoryScrollViewPositionMode storyScrollViewPositionMode;


-(id)initWithParentController:(GCStoryController *)controller ScrollerNumber:(NSInteger)ScrollerNumber;
-(void)setupBlankStoryScrollView;
-(void)loadStoryScrollViewContent;



-(void)moveStoryScrollViewToMiddel;
-(void)moveStoryScrollViewToRight;
-(void)moveStoryScrollViewToLeft;

@end
