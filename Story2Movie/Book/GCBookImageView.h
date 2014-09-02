//
//  GCBookImageView.h
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCBookScrollView;

@interface GCBookImageView : UIImageView

#pragma mark - AppUtility
@property GCAppUtility *utility;

@property GCBookScrollView *parentView;
@property NSInteger bookNumber;
@property FBShimmeringView *bookTitleView;
@property AFHTTPRequestOperationManager *manager;

-(id)initBlankBookImageViewWithParentView:(GCBookScrollView *)ParentView bookNumber:(NSInteger)number;
-(void)loadBookImage;


@end
