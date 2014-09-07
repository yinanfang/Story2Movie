//
//  GCStoryScrollView.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCStoryCollectionController;
#import "GCStoryController.h"

@interface GCStoryScrollView : UIScrollView <UIScrollViewDelegate, UIGestureRecognizerDelegate>

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCStoryCollectionController *parentController;

#pragma mark - Story View
@property NSInteger storyScrollViewNumber, storyCount;
@property CGFloat WidthForSmallStory, HeightForSmallStory;
@property NSMutableArray *storyControllerArray;



- (id)initWithParentController:(GCStoryCollectionController *)controller ScrollViewNumber:(NSInteger)number;
- (void)loadStoryScrollViewContent;


#pragma mark - Story Scroll View Movement
-(void)moveStoryScrollViewToMiddel;
-(void)moveStoryScrollViewToRight;
-(void)moveStoryScrollViewToLeft;


@end
