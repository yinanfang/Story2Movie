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
@synthesize parentController, bookPageControl;
@synthesize manager, bookCount, bookCurrentPageNumber, bookNames, bookImageViews;
@synthesize previousBookImageView, bookImageRightMostConstraint;

#pragma mark - Blank Frame Initialization
- (id)initWithParentController:(GCBookController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        manager = [AFHTTPRequestOperationManager manager];
        bookCount = [[[GCAppConfig sharedInstance] defaultBookCount] integerValue];
        bookImageViews = [[NSMutableArray alloc] init];
        bookCurrentPageNumber = [[GCAppConfig sharedInstance] bookCurrentPageNumber];
        
        // Empty Frame Initialization
        self.pagingEnabled = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        [parentController.view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(parentController.view);
        }];
    }
    return self;
}

-(void)setupBlankBookScrollView
{
    // Prepare Blank Book Image with loading sign with shimmering effect
    bookPageControl = parentController.bookPageControl;
    previousBookImageView = nil;
    for (int i = 0; i < bookCount; i++) {
        GCBookImageView *imageView = [[GCBookImageView alloc] initBlankBookImageViewWithParentView:self bookNumber:i];
        [bookImageViews addObject:imageView];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(ScreenWidth-2, ScreenHeight)]);
            make.top.equalTo(self.mas_top);
        }];
        if (!previousBookImageView) { // First one, pin to top
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(1);
            }];
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousBookImageView.mas_right).offset(2);
            }];
        }
        if (i == bookCount-1) { // Last one, pin to right
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                bookImageRightMostConstraint = make.right.equalTo(self.mas_right).offset(-1);
            }];
        }
        previousBookImageView = imageView;
    }
}

-(void)loadBookScrollViewContent
{
    DDLogWarn(@"Start loading Book");
    // Add book image view if new book count is different
    NSInteger defaultBookCount = bookCount;
    NSString *keyPathForBookCountInAppGeneral = [NSString stringWithFormat:@"bookCount"];
    bookCount = [[[[GCAppConfig sharedInstance] AppGeneral] objectForKey:keyPathForBookCountInAppGeneral] integerValue];
    if (bookCount != defaultBookCount) {
        DDLogWarn(@"adding more book image view");
        [bookImageRightMostConstraint uninstall];
        for (int i = (int)defaultBookCount; i < bookCount; i++) {
            GCBookImageView *imageView = [[GCBookImageView alloc] initBlankBookImageViewWithParentView:self bookNumber:i];
            [bookImageViews addObject:imageView];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(ScreenWidth-2, ScreenHeight)]);
                make.top.equalTo(self.mas_top);
            }];
            // Stick to the last image view
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousBookImageView.mas_right).offset(2);
            }];
            if (i == bookCount-1) { // Last one, pin to right
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    bookImageRightMostConstraint = make.right.equalTo(self.mas_right).offset(-1);
                }];
            }
            previousBookImageView = imageView;
        }
    }
    DDLogWarn(@"Loop through and call load method in image views");
    for (GCBookImageView *bookImageView in bookImageViews) {
        [bookImageView loadBookImage];
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
    DDLogVerbose(@"page number before addjust: %li", (long)bookPageControl.currentPage);
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
