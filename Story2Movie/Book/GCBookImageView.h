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

@property UIView *parentView;
@property FBShimmeringView *bookTitleView;

-(id)initBlankBookImageViewWithParentView:(GCBookScrollView *)ParentView;



@end
