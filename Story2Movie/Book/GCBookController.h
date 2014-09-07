//
//  GCBookController.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCBookScrollView;
#import "GCBookView.h"

@interface GCBookController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCBookScrollView *parentView;

#pragma mark - Book Controller
@property NSInteger bookNumber;
@property GCBookView *bookView;



- (id)initWithFrame:(CGRect)frame ParentView:(GCBookScrollView *)view bookNumber:(NSInteger)number;


@end
