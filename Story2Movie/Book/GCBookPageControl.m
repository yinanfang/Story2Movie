//
//  GCBookPageControl.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookController.h"
#import "GCBookPageControl.h"

@implementation GCBookPageControl
@synthesize utility;
@synthesize parentController;


- (id)initWithParentController:(GCBookController *)controller
{
    self = [super init];
    if (self) {
        // Get Utility object
        utility = [GCAppUtility sharedInstance];
        
        // Initialization Variables
        parentController = controller;
        
        // Empty Frame Initialization
        self.numberOfPages = [[AppConfig sharedInstance] bookCount];
        self.currentPage = 0;
        self.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.currentPageIndicatorTintColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        self.enabled = NO;  // Disable the "clickPageControl" method
        [parentController.view addSubview:self];
        
        // Observe value changes
        [RACObserve(self, currentPage) subscribeNext:^(NSNumber *newPageNumber){
            [AppConfig sharedInstance].bookCurrentPageNumber = [newPageNumber integerValue];
            DDLogVerbose(@"RAC updated [AppConfig sharedInstance].bookCurrentPageNumber to %li", [AppConfig sharedInstance].bookCurrentPageNumber);
        }];
    }
    return self;
}
-(void)setupBookPageControl
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(320, 30)]);
        make.bottom.equalTo(parentController.storyController.view.mas_top);
        make.centerX.equalTo(parentController.view.mas_centerX);
    }];
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
