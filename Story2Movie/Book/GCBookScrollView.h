//
//  GCBookScrollView.h
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBookImageView.h"
#import "GCBookPageControl.h"
@class GCBookController;

@interface GCBookScrollView : UIScrollView <UIScrollViewDelegate>

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCBookController *parentController;
@property GCBookPageControl *bookPageControl;

#pragma mark - Book View
@property AFHTTPRequestOperationManager *manager;
@property NSInteger bookCount, bookCurrentPageNumber;
@property NSMutableArray *bookNames, *bookImageViews;
@property GCBookImageView *previousBookImageView;
@property MASConstraint *bookImageRightMostConstraint;


-(id)initWithParentController:(GCBookController *)controller;
-(void)setupBlankBookScrollView;
-(void)loadBookScrollViewContent;


@end
