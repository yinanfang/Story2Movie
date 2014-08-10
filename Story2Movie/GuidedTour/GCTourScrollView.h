//
//  TourScrollView.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCGalleryViewController.h"

@interface GCTourScrollView : UIScrollView

#pragma mark - AppUtility
@property GCAppUtility *utility;

@property NSMutableArray *tourImages_array;
@property UIViewController *parentController;
@property UIView *contentView;


-(id)initWithParentController:(UIViewController *)controller;
-(void)setupTourScrollView;

@end
