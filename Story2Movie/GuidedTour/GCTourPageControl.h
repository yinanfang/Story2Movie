//
//  TourPageControl.h
//  Story2Movie
//
//  Created by Golden Compass on 8/5/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCTourPageControl : UIPageControl

@property UIViewController *parentController;

-(id)initWithParentController:(UIViewController *)controller;

@end
