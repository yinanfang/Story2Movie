//
//  GCStoryImageView.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCStoryImageView.h"
#import "GCStoryScrollView.h"

@implementation GCStoryImageView
@synthesize parentView;

-(id)initBlankStoryImageViewWithParentView:(GCStoryScrollView *)ParentView
{
    self = [super init];
    if (self) {
        // Initialization variables
        parentView = ParentView;
        
        // Customize Book Image View
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 5;
        
        
        
        // testing purpose
        if (parentView.storyScrollerNumber == 0) {
            self.backgroundColor = [UIColor redColor];
        }else if (parentView.storyScrollerNumber == 1) {
            self.backgroundColor = [UIColor blueColor];
        }else if (parentView.storyScrollerNumber == 2) {
            self.backgroundColor = [UIColor yellowColor];
        }
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
