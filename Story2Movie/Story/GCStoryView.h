//
//  GCStoryView.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCStoryScrollView;
@class GCStoryController;


@interface GCStoryView : UIView

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCStoryController *parentController;
@property CGFloat WidthForSmallStory, HeightForSmallStory;
@property CGFloat PixelAdjustForHorizontalGap;
@property AFHTTPRequestOperationManager *manager;



- (id)initWithParentController:(GCStoryController *)controller;
- (void)loadStoryContent;

@end
