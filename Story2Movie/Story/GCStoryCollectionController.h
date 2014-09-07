//
//  GCStoryCollectionController.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCBookCollectionController;
#import "GCStoryScrollView.h"

@interface GCStoryCollectionController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCBookCollectionController *parentController;

#pragma mark - Book
@property NSInteger bookCount;

#pragma mark - Story
@property NSMutableArray *storyScrollViewArray;








-(id)initWithParentController:(GCBookCollectionController *)controller;
- (void)loadStoryCollectionControllerContent;



@end
