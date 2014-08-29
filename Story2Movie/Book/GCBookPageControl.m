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
        // Initialize Utility object
        utility = [[GCAppUtility alloc] init];
        
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
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(320, 20)]);
            make.bottom.equalTo(parentController.view.mas_bottom).offset(-260);
            make.centerX.equalTo(parentController.view.mas_centerX);
        }];

        // Observe value changes
        NSInteger *test;
        
        
        
//        [[RACObserve(self, currentPage) subscribeNext:^(NSInteger *newPageNumber){
//            DDLogWarn(@"number: %@", newPageNumber);
//        }]];
        
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
