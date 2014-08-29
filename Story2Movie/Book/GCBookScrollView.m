//
//  GCBookScrollView.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookController.h"
#import "GCBookScrollView.h"

@implementation GCBookScrollView
@synthesize utility;
@synthesize parentController, bookPageControl, manager, bookCount, bookCurrentPageNumber, bookNames, bookImageViews;


- (id)initWithParentController:(GCBookController *)controller
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        // Initialize Utility object
        utility = [[GCAppUtility alloc] init];
        
        // Initialization Variables
        parentController = controller;
        bookPageControl = parentController.bookPageControl;
        manager = [AFHTTPRequestOperationManager manager];
        bookCount = [[AppConfig sharedInstance] bookCount];
        bookCurrentPageNumber = [[AppConfig sharedInstance] bookCurrentPageNumber];
        
        // Empty Frame Initialization
        [self initWithBlankFrame];
    }
    return self;
}

#pragma mark - Blank Frame Initialization
-(void)initWithBlankFrame
{
    // Prepare Book Scroll View
    self.pagingEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = YES;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
    [parentController.view insertSubview:self belowSubview:parentController.bookPageControl];
    [self mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(parentController.view);
    }];
    
    // Prepare Blank Book Image with loading sign with shimmering effect
    GCBookImageView *previousImageView = nil;
    for (int i = 0; i < bookCount; i++) {
        GCBookImageView *imageView = [[GCBookImageView alloc] initBlankBookImageViewWithParentView:self];
        [bookImageViews addObject:imageView];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(ScreenWidth-2, ScreenHeight)]);
            make.top.equalTo(self.mas_top);
        }];
        if (!previousImageView) { // First one, pin to top
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(1);
            }];
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousImageView.mas_right).offset(2);
            }];
        }
        if (i == bookCount-1) { // Last one, pin to right
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-1);
            }];
        }else{
            previousImageView = imageView;
        }
    }
}

#pragma mark - UIScrollViewDelegate Protocol
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self updateBookPageControlWithScrollView:scrollView velocity:velocity];
}

- (void)updateBookPageControlWithScrollView:(UIScrollView *)scrollView velocity:(CGPoint)velocity
{
    NSInteger newPageNumber;
    DDLogVerbose(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    DDLogVerbose(@"content offset: %f", scrollView.contentOffset.x);
    DDLogVerbose(@"velocity: %f", velocity.x);
    DDLogVerbose(@"page number before addjust: %i", bookPageControl.currentPage);
    
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
    DDLogVerbose(@"new page number: %i", newPageNumber);
    [AppConfig sharedInstance].bookCurrentPageNumber = newPageNumber;
    bookPageControl.currentPage = newPageNumber;
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
