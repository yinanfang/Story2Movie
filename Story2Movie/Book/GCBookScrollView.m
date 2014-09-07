//
//  GCBookScrollView.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookCollectionController.h"
#import "GCBookScrollView.h"

@implementation GCBookScrollView
@synthesize utility;
@synthesize parentController;

- (id)initWithParentController:(GCBookCollectionController *)controller
{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        // Initialization code
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        
        
        
        // Empty Frame Initialization
        self.pagingEnabled = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor lightGrayColor];
        [parentController.view addSubview:self];
        
    }
    return self;
}







@end
