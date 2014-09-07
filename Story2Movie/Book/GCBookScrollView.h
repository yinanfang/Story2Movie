//
//  GCBookScrollView.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCBookCollectionController;
#import "GCBookPageControl.h"
#import "GCBookController.h"
#import "GCStoryScrollView.h"

@interface GCBookScrollView : UIScrollView <UIScrollViewDelegate>

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Entities
@property GCBookCollectionController *parentController;
@property GCBookPageControl *bookPageControl;

#pragma mark - Book Controller
@property NSInteger bookCount;
@property NSMutableArray *bookControllerArray;







- (id)initWithParentController:(GCBookCollectionController *)controller;
- (void)loadBookScrollViewContent;



@end
