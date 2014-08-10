//
//  TourPageControl.m
//  Story2Movie
//
//  Created by Golden Compass on 8/5/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCTourPageControl.h"

@implementation GCTourPageControl
@synthesize parentController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithParentController:(UIViewController *)controller
{
    parentController = controller;
    self = [super init];
    if (self) {
        // Initialization code
        self.numberOfPages = count_tourPages;
        self.currentPage = 0;
        self.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.currentPageIndicatorTintColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        self.enabled = NO;  // Disable the "clickPageControl" method
        [parentController.view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(320, 70)]);
            make.bottom.equalTo(parentController.view.mas_bottom).offset(-10);
            make.centerX.equalTo(parentController.view.mas_centerX);
        }];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
