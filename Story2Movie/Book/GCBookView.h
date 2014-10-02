//
//  GCBookView.h
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCBookController;

@interface GCBookView : UIView

#pragma mark - AppUtility
@property(readonly) GCAppUtility *utility;

#pragma mark - Parent Controller
@property GCBookController *parentController;
@property CGFloat PixelAdjustForHorizontalGap;
@property FBShimmeringView *bookTitleView;
@property UILabel *bookTitleLabel;
@property AFHTTPRequestOperationManager *manager;


- (id)initWithParentController:(GCBookController *)controller;
- (void)loadBookContent;



@end
