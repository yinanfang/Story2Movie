//
//  GCStoryCollectionController.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCBookCollectionController;

@interface GCStoryCollectionController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCBookCollectionController *parentController;









-(id)initWithParentController:(GCBookCollectionController *)controller;



@end
