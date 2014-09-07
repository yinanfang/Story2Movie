//
//  GCStoryController.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCStoryController.h"
#import "GCStoryScrollView.h"

@interface GCStoryController ()

@end

@implementation GCStoryController
@synthesize utility;
@synthesize parentView;
@synthesize storyNumber;
@synthesize WidthForSmallStory, HeightForSmallStory;
@synthesize PixelAdjustForHorizontalGap;
@synthesize storyView;


- (id)initWithFrame:(CGRect)frame ParentView:(GCStoryScrollView *)view StoryNumber:(NSInteger)number
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        parentView = view;
        storyNumber = number;
        WidthForSmallStory = [[GCAppConfig sharedInstance] WidthForSmallStory];
        HeightForSmallStory = [[GCAppConfig sharedInstance] HeightForSmallStory];
        PixelAdjustForHorizontalGap = [[GCAppConfig sharedInstance] PixelAdjustForHorizontalGap];
        
        // Empty Frame Initialization
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor clearColor];
        storyView = [[GCStoryView alloc] initWithParentController:self];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
