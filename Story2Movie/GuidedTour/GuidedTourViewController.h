//
//  GuidedTourViewController.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourScrollView.h"
#import "TourPageControl.h"

@interface GuidedTourViewController : UIViewController

#pragma mark - AppUtility
@property AppUtility *utility;

@property NSMutableArray *tourImages_array;
@property TourScrollView *tourScrollView;
@property TourPageControl *tourPageControl;

@end
