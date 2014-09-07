//
//  GCBookCollectionController.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBookScrollView.h"
#import "GCBookPageControl.h"
#import "GCStoryCollectionController.h"

@interface GCBookCollectionController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Networking
@property AFHTTPRequestOperationManager *manager;

#pragma mark - Book
@property GCBookScrollView *bookScrollView;
@property GCBookPageControl *bookPageControl;

#pragma mark - Story
@property GCStoryCollectionController *storyCollectionController;

@end
