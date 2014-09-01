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
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        self.view.backgroundColor = [UIColor blackColor];
        self.view.frame = CGRectMake(0, ScreenHeight-[[AppConfig sharedInstance] StoryImageHeight], ScreenWidth, [[AppConfig sharedInstance] StoryImageHeight]);    // Set a frame for other view to reference to. Set constraint later in didMoveToParentViewController
        parentController = controller;
        
        // Empty Frame Initialization
        storyScrollViewArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [[[AppConfig sharedInstance] defaultBookCount] integerValue]; i++) {
            storyScrollView = [[GCStoryScrollView alloc] initWithParentController:self ScrollerNumber:i];
            [storyScrollViewArray insertObject:storyScrollView atIndex:i];
        }
    }
    return self;
}




-(void)willMoveToParentViewController:(UIViewController *)parent
{
    DDLogVerbose(@"will move to parent view controller");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogVerbose(@"view did load");
}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    DDLogVerbose(@"did move to parent view controller");
    // Setting view constraint after it's added to the super view
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(parentController.view.mas_width);
        make.height.equalTo(@([[AppConfig sharedInstance] StoryImageHeight]));
        make.centerX.equalTo(parentController.view.mas_centerX);
        make.bottom.equalTo(parentController.view.mas_bottom);
    }];
    
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
