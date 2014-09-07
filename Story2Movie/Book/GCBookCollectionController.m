//
//  GCBookCollectionController.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookCollectionController.h"

@interface GCBookCollectionController ()

@end

@implementation GCBookCollectionController
@synthesize utility;
@synthesize manager;
@synthesize bookScrollView, bookPageControl;
@synthesize storyCollectionController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    DDLogInfo(@"====================  Entered main menu page  ====================");
    
    // Initialization Variables
    utility = [GCAppUtility sharedInstance];
    manager = [AFHTTPRequestOperationManager manager];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor clearColor];
    
    // Main init methods
    [self initBookAndStory];
    
}

-(void)initBookAndStory
{
    bookScrollView = [[GCBookScrollView alloc] initWithParentController:self];
    bookPageControl = [[GCBookPageControl alloc] initWithParentController:self];
    storyCollectionController = [[GCStoryCollectionController alloc] initWithParentController:self];
    [self addChildViewController:storyCollectionController];
    [self.view addSubview:storyCollectionController.view];
    [storyCollectionController didMoveToParentViewController:self];
}





#pragma mark - General View Methods
// Hide the status bar on the tour page
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
