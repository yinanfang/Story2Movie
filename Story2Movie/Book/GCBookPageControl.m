//
//  GCBookPageControl.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookCollectionController.h"
#import "GCBookPageControl.h"

@implementation GCBookPageControl
@synthesize utility;
@synthesize parentController;

- (id)initWithParentController:(GCBookCollectionController *)controller
{
    self = [super initWithFrame:[[GCAppConfig sharedInstance] PageControlRect]];
    if (self) {
        // Initialization code
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        
        // Empty Frame Initialization
        self.numberOfPages = [[[GCAppConfig sharedInstance] defaultBookCount] integerValue];
        self.currentPage = 0;
        self.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.currentPageIndicatorTintColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        self.enabled = NO;  // Disable the "clickPageControl" method
        [parentController.view addSubview:self];

        // Observe value changes
        [RACObserve(self, currentPage) subscribeNext:^(NSNumber *newPageNumber){
            [GCAppConfig sharedInstance].bookCurrentPageNumber = [newPageNumber integerValue];
            DDLogVerbose(@"RAC updated [AppConfig sharedInstance].bookCurrentPageNumber to %li", (long)[GCAppConfig sharedInstance].bookCurrentPageNumber);
        }];
    }
    return self;
}






@end
