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
        // Initialization Variables
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
-(void)setupBookPageControl
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(320, 30)]);
        make.bottom.equalTo(parentController.storyController.view.mas_top);
        make.centerX.equalTo(parentController.view.mas_centerX);
    }];
    
    // Move Story Scroll View accordingly
    [RACObserve(self, currentPage) subscribeNext:^(NSNumber *newPageNumber){
        for (GCStoryScrollView *storyScrollView in parentController.storyController.storyScrollViewArray) {
            if (storyScrollView.storyScrollerNumber < [newPageNumber integerValue]) {
                [storyScrollView moveStoryScrollViewToLeft];
            }else if (storyScrollView.storyScrollerNumber == [newPageNumber integerValue]) {
                [storyScrollView moveStoryScrollViewToMiddel];
            }else if (storyScrollView.storyScrollerNumber > [newPageNumber integerValue]) {
                [storyScrollView moveStoryScrollViewToRight];
            }
        }    
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
