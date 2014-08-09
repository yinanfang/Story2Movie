//
//  GuidedTourViewController.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCTourScrollView.h"
#import "GCTourPageControl.h"

@interface GCGuidedTourViewController : UIViewController

#pragma mark - AppUtility
@property GCAppUtility *utility;

@property NSMutableArray *tourImages_array;
@property GCTourScrollView *tourScrollView;
@property GCTourPageControl *tourPageControl;

@end
