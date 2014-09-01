//
//  GCStoryController.h
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCBookController;
#import "GCStoryScrollView.h"

@interface GCStoryController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCBookController *parentController;

#pragma mark - Story
@property NSMutableArray *storyScrollViewArray;
@property GCStoryScrollView *storyScrollView;


-(id)initWithParentController:(GCBookController *)controller;



@end
