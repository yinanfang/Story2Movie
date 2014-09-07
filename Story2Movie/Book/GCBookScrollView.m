//
//  GCBookScrollView.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookCollectionController.h"
#import "GCBookScrollView.h"

@implementation GCBookScrollView
@synthesize utility;
@synthesize parentController, bookPageControl;
@synthesize bookCount;
@synthesize bookControllerArray;


- (id)initWithParentController:(GCBookCollectionController *)controller
{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        // Initialize Variables
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        bookCount = [[[GCAppConfig sharedInstance] defaultBookCount] integerValue];
        bookControllerArray = [[NSMutableArray alloc] init];
        bookPageControl = parentController.bookPageControl;
        
        // Empty Frame Initialization
        self.pagingEnabled = YES;
        self.delegate = self;
        self.scrollEnabled = YES;
        self.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;        // TODO: No to this will also hide horizontal indicator??
        self.backgroundColor = [UIColor clearColor];
        [parentController.view insertSubview:self belowSubview:parentController.bookPageControl];
        // Add book controller after adding the book scroll view
        for (int bookNumber = 0; bookNumber < bookCount; bookNumber++) {
            GCBookController *bookController = [[GCBookController alloc] initWithFrame:CGRectMake(ScreenWidth*bookNumber, 0, ScreenWidth, ScreenHeight) ParentView:self bookNumber:bookNumber];
            [parentController addChildViewController:bookController];
            [self addSubview:bookController.view];
            [bookController didMoveToParentViewController:parentController];
            [bookControllerArray insertObject:bookController atIndex:bookNumber];
        }
        self.contentSize = CGSizeMake(ScreenWidth*bookCount, ScreenHeight);
        
    }
    return self;
}

- (void)loadBookScrollViewContent
{
    DDLogWarn(@"Start loading Book Controller in Book Scroll View...");
    // Add book image view if new book count is different
    NSInteger defaultBookCount = bookCount;
    NSString *keyPathForBookCountInAppGeneral = [NSString stringWithFormat:@"bookCount"];
    bookCount = [[[[GCAppConfig sharedInstance] AppGeneral] objectForKey:keyPathForBookCountInAppGeneral] integerValue];
    if (bookCount != defaultBookCount) {
        DDLogWarn(@"adding more book image view");
        for (int bookNumber = (int)defaultBookCount; bookNumber < bookCount; bookNumber++) {
            GCBookController *bookController = [[GCBookController alloc] initWithFrame:CGRectMake(ScreenWidth*bookNumber, 0, ScreenWidth, ScreenHeight) ParentView:self bookNumber:bookNumber];
            [parentController addChildViewController:bookController];
            [self addSubview:bookController.view];
            [bookController didMoveToParentViewController:parentController];
            [bookControllerArray insertObject:bookController atIndex:bookNumber];
        }
        bookPageControl.numberOfPages = bookCount;
        self.contentSize = CGSizeMake(ScreenWidth*bookCount, ScreenHeight);
        DDLogWarn(@"Loop through and call load method in image views");
        for (GCBookController *bookController in bookControllerArray) {
            [bookController.bookView loadBookContent];
        }
    }
    
}







#pragma mark - UIScrollViewDelegate Protocol
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger newPageNumber;
    DDLogVerbose(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>> book scroll view");
    DDLogVerbose(@"content offset: %f - velocity: %f - page number before addjust: %li", scrollView.contentOffset.x, velocity.x, (long)bookPageControl.currentPage);
    
    if (fabs(velocity.x) <= SWIPE_VELOCITY_THRESHOLD) {    // Pan motion
        DDLogVerbose(@"pan motion");
        newPageNumber = (scrollView.contentOffset.x/ScreenWidth)+0.5;
    }else{
        DDLogVerbose(@"swipe motion");
        newPageNumber = (velocity.x > 0) ? bookPageControl.currentPage+1 : bookPageControl.currentPage-1;
        if (newPageNumber < 0) {
            newPageNumber = 0;
        }
        if(newPageNumber >= scrollView.contentSize.width/ScreenWidth){
            newPageNumber = ceil(scrollView.contentSize.width/ScreenWidth) - 1;
        }
    }
    DDLogVerbose(@"new page number: %li", (long)newPageNumber);
    bookPageControl.currentPage = newPageNumber;
}






@end
