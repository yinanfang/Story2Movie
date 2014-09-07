//
//  GCStoryCollectionController.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookCollectionController.h"
#import "GCStoryCollectionController.h"

@interface GCStoryCollectionController ()

@end

@implementation GCStoryCollectionController
@synthesize utility;
@synthesize parentController;


- (id)initWithParentController:(GCBookCollectionController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        self.view.backgroundColor = [UIColor grayColor];
        parentController = controller;
        self.view.frame = [[GCAppConfig sharedInstance] BoundsForStoryCollectionController];
        
        // Empty Frame Initialization

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
