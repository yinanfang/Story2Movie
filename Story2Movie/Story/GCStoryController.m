//
//  GCStoryController.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookController.h"
#import "GCStoryController.h"

@interface GCStoryController ()

@end

@implementation GCStoryController
@synthesize utility;
@synthesize parentController;
@synthesize storyScrollViewArray, storyScrollView;

- (id)initWithParentController:(GCBookController *)controller
{
    self = [super init];
    if (self) {
        // Get Utility object
        utility = [GCAppUtility sharedInstance];
        
        // Initialization Variables
        self.view.backgroundColor = [UIColor blackColor];
        self.view.frame = CGRectMake(0, ScreenHeight-[[AppConfig sharedInstance] StoryImageHeight], ScreenWidth, [[AppConfig sharedInstance] StoryImageHeight]);
        parentController = controller;
        
        // Empty Frame Initialization
        storyScrollViewArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [[AppConfig sharedInstance] bookCount]; i++) {
            storyScrollView = [[GCStoryScrollView alloc] initWithParentController:self ScrollerNumber:i];
            [storyScrollViewArray insertObject:storyScrollView atIndex:i];
        }
    }
    return self;
}




-(void)willMoveToParentViewController:(UIViewController *)parent
{
    DDLogWarn(@"will move to parent view controller");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogWarn(@"view did load");
}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    DDLogWarn(@"did move to parent view controller");
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
