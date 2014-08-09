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
@synthesize tourImages_array, tourScrollView, tourPageControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogInfo(@"====================  Entered tour page  ====================");
    // Initialize Utility object
    utility = [[GCAppUtility alloc] init];
        
    [self fetchImages];
    
    tourScrollView = [[GCTourScrollView alloc] initWithImageArray:tourImages_array ParentController:self];
    [self.view addSubview:tourScrollView];
}
- (void)fetchImages
{
    tourImages_array = [[NSMutableArray alloc] init];
    for (int i = 0; i < count_tourPages; i++) {
        NSString *imageName = [NSString stringWithFormat:@"tour_%i", i];
        UIImageView *imageView = [utility getFullScreenImageView:imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [tourImages_array addObject:imageView];
    }
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
