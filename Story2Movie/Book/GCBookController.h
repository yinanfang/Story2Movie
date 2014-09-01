//
//  GCBookController.h
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBookScrollView.h"
#import "GCBookPageControl.h"
#import "GCStoryController.h"
#import "GCStoryScrollView.h"

@interface GCBookController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Book
@property GCBookScrollView *bookScrollView;
@property GCBookPageControl *bookPageControl;

#pragma mark - Story
@property GCStoryController *storyController;

#pragma mark - Networking
@property AFHTTPRequestOperationManager *manager;




@end
