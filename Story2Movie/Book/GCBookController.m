//
//  GCBookController.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookController.h"

@interface GCBookController ()

@end

@implementation GCBookController
@synthesize utility;
@synthesize bookScrollView, bookPageControl;
@synthesize storyController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogInfo(@"====================  Entered main menu page  ====================");
    
    // Get Utility object
    utility = [GCAppUtility sharedInstance];
    
    // Main init methods
    [self initAndSetupBookAndStory];
}

-(void)initAndSetupBookAndStory
{
    bookScrollView = [[GCBookScrollView alloc] initWithParentController:self];
    bookPageControl = [[GCBookPageControl alloc] initWithParentController:self];
    
    storyController = [[GCStoryController alloc] initWithParentController:self];
    [self addChildViewController:storyController];
    [self.view addSubview:storyController.view];
    [storyController didMoveToParentViewController:self];
    
    [bookScrollView setupBlankBookScrollView];
    [bookPageControl setupBookPageControl];
    for (GCStoryScrollView *storyScroller in storyController.storyScrollViewArray) {
        [storyScroller setupBlankStoryScrollView];
    }
}












#pragma mark - General View Methods
// Hide the status bar on the tour page
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

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
