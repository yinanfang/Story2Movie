//
//  GCStoryController.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCStoryScrollView;
#import "GCStoryView.h"

@interface GCStoryController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCStoryScrollView *parentView;

#pragma mark - Story
@property NSInteger storyNumber;
@property CGFloat WidthForSmallStory, HeightForSmallStory;
@property CGFloat PixelAdjustForHorizontalGap;
@property GCStoryView *storyView;





- (id)initWithFrame:(CGRect)frame ParentView:(GCStoryScrollView *)view StoryNumber:(NSInteger)number;



@end
