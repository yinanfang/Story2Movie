//
//  GCBookImageView.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookScrollView.h"
#import "GCBookImageView.h"

@implementation GCBookImageView
@synthesize parentView;
@synthesize bookTitleView;

-(id)initBlankBookImageViewWithParentView:(GCBookScrollView *)ParentView
{
    self = [super init];
    if (self) {
        // Initialization code
        parentView = ParentView;
        
        // Customize Book Image View
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 5;
        
        // Add book title with shimmer effect
        bookTitleView = [[FBShimmeringView alloc] initWithFrame:ScreenBounds];
        bookTitleView.shimmering = YES;
        bookTitleView.shimmeringBeginFadeDuration = 0.3;
        bookTitleView.shimmeringPauseDuration = 3;
        bookTitleView.shimmeringSpeed = 250;
        bookTitleView.shimmeringOpacity = 0.5;
        [self addSubview:bookTitleView];
        UIEdgeInsets padding = UIEdgeInsetsMake(15, 15, 10, 10);
        [bookTitleView mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(120, 23)]);
            make.top.equalTo(self.mas_top).with.offset(padding.top);
            make.left.equalTo(self.mas_left).with.offset(padding.left);
        }];
        UILabel *bookTitleLabel = [[UILabel alloc] init];
        bookTitleLabel.textAlignment = NSTextAlignmentCenter;
        bookTitleLabel.text = @"Story2Movie";
        bookTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:23];
        bookTitleLabel.textColor = [UIColor whiteColor];
        bookTitleLabel.backgroundColor = [UIColor clearColor];
        bookTitleView.contentView = bookTitleLabel;
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
