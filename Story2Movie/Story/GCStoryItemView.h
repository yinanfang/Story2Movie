//
//  GCStoryImageView.h
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCStoryScrollView;

@interface GCStoryItemView : UIImageView <UIGestureRecognizerDelegate>

#pragma mark - AppUtility
@property GCAppUtility *utility;

@property GCStoryScrollView *parentView;
@property NSInteger storyNumber;
@property AFHTTPRequestOperationManager *manager;

-(id)initBlankStoryImageViewWithParentView:(GCStoryScrollView *)ParentView storyNumber:(NSInteger)number;
-(void)loadStoryImage;

@end
