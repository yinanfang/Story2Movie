//
//  TourScrollView.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourScrollView : UIScrollView

@property NSMutableArray *tourImages_array;
@property UIViewController *parentController;
@property UIView *contentView;


-(id)initWithImageArray:(NSMutableArray *)img_arr ParentController:(UIViewController *)controller;


@end
