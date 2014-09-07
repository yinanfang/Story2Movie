//
//  GCBookController.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookController.h"
#import "GCBookScrollView.h"

@interface GCBookController ()

@end

@implementation GCBookController
@synthesize utility;
@synthesize parentView;
@synthesize bookNumber, bookView;


- (id)initWithFrame:(CGRect)frame ParentView:(GCBookScrollView *)view bookNumber:(NSInteger)number
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        parentView = view;
        bookNumber = number;
        
        // Empty Frame Initialization
        self.view.backgroundColor = [UIColor clearColor];
        self.view.frame = frame;
        bookView = [[GCBookView alloc] initWithParentController:self];
        
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
