//
//  GuidedTourViewController.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCGuidedTourViewController.h"

@interface GCGuidedTourViewController ()

@end

@implementation GCGuidedTourViewController
@synthesize utility;
@synthesize tourScrollView, tourPageControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogInfo(@"====================  Entered tour page  ====================");
    // Initialize Utility object
    utility = [[GCAppUtility alloc] init];

    tourScrollView = [[GCTourScrollView alloc] initWithParentController:self];
    [tourScrollView setupTourScrollView];
    tourScrollView.delegate = self;
    
    // Set up PageControl
    tourPageControl = [[GCTourPageControl alloc] initWithParentController:self];
}

#pragma mark - UIScrollViewDelegate Protocol
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    DDLogVerbose(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>content offset: %f", scrollView.contentOffset.x);
    DDLogVerbose(@"velocity: %f", velocity.x);
    int newPageNumber;
    if (fabs(velocity.x) <= SWIPE_VELOCITY_THRESHOLD) {    // Pan motion
        DDLogVerbose(@"pan motion");
        newPageNumber = (scrollView.contentOffset.x/ScreenWidth)+0.5;
    }else{
        DDLogVerbose(@"swipe motion");
        newPageNumber = (velocity.x > 0) ? tourPageControl.currentPage+1 : tourPageControl.currentPage-1;
        DDLogVerbose(@"page number before addjust: %i", newPageNumber);
        if (newPageNumber < 0) {
            newPageNumber = 0;
        }
        if(newPageNumber >= scrollView.contentSize.width/ScreenWidth){
            newPageNumber = ceil(scrollView.contentSize.width/ScreenWidth) - 1;
        }
    }
    DDLogVerbose(@"page number: %i", newPageNumber);
    [self updatePageControl:newPageNumber];
}

-(void)updatePageControl:(int)pageNumber
{
    tourPageControl.currentPage = pageNumber;
}

// Hide the status bar on the tour page
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UIViewController Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
