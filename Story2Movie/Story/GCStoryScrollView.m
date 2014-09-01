//
//  GCStoryScrollView.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCStoryController.h"

@implementation GCStoryScrollView
@synthesize utility;
@synthesize parentController;
@synthesize manager, storyScrollerNumber, storyCount, StoryImageHeight, StoryImageWidth;
@synthesize storyNames, storyImageViews;

#pragma mark - Blank Frame Initialization
-(id)initWithParentController:(GCStoryController *)controller ScrollerNumber:(NSInteger)ScrollerNumber
{
    self = [super init];
    if (self) {
        // Initialization Variables
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        manager = [AFHTTPRequestOperationManager manager];
        storyScrollerNumber = ScrollerNumber;
        storyCount = [[[AppConfig sharedInstance] defaultStoryCount] integerValue];
        StoryImageWidth = [[AppConfig sharedInstance] StoryImageWidth];
        StoryImageHeight = [[AppConfig sharedInstance] StoryImageHeight];
        
        // Empty Frame Initialization
        self.pagingEnabled = NO;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        [parentController.view addSubview:self];
        
        // Only place the first scroll view in the middle
        if (ScrollerNumber == 0) {
            [self mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(parentController.view.mas_top);
                make.left.equalTo(parentController.view.mas_left);
                make.bottom.equalTo(parentController.view.mas_bottom);
                make.right.equalTo(parentController.view.mas_right);
            }];
        }else {
            [self mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(parentController.view.mas_top);
                make.left.equalTo(parentController.view.mas_left).with.offset(ScreenWidth);
                make.bottom.equalTo(parentController.view.mas_bottom);
                make.right.equalTo(parentController.view.mas_right).with.offset(ScreenWidth);
            }];
        }

        // Observe value changes
        [RACObserve(self, StoryImageWidth) subscribeNext:^(NSNumber *newWidth){
            [AppConfig sharedInstance].StoryImageWidth = [newWidth floatValue];
            DDLogVerbose(@"RAC updated [AppConfig sharedInstance].StoryImageWidth to %f", [AppConfig sharedInstance].StoryImageWidth);
        }];
        [RACObserve(self, StoryImageHeight) subscribeNext:^(NSNumber *newHeight){
            [AppConfig sharedInstance].StoryImageHeight = [newHeight floatValue];
            DDLogVerbose(@"RAC updated [AppConfig sharedInstance].StoryImageHeight to %f", [AppConfig sharedInstance].StoryImageHeight);
        }];
        
        DDLogVerbose(@"Init StoryScrollView: %li; Story Count: %li", (long)ScrollerNumber, (long)storyCount);
    }
    return self;
}

-(void)setupBlankStoryScrollView
{
    // Prepare Blank Story Image with loading sign with shimmering effect
    GCStoryImageView *previousImageView = nil;
    for (int i = 0; i < storyCount; i++) {
        GCStoryImageView *imageView = [[GCStoryImageView alloc] initBlankStoryImageViewWithParentView:self];
        [storyImageViews addObject:imageView];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(StoryImageHeight));
            make.width.equalTo(@(StoryImageHeight*(ScreenWidth/ScreenHeight)));
//            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(StoryImageWidth-2, StoryImageHeight)]);
            make.top.equalTo(self.mas_top);
        }];
        if (!previousImageView) { // First one, pin to top
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(1);
            }];
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousImageView.mas_right).offset(2);
            }];
        }
        if (i == storyCount-1) { // Last one, pin to right
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-1);
            }];
        }else{
            previousImageView = imageView;
        }
    }
}

-(void)moveStoryScrollViewToMiddel
{
    [parentController.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(parentController.view.mas_left);
            make.right.equalTo(parentController.view.mas_right);
        }];
        [parentController.view layoutIfNeeded];
    }completion:nil];
}

-(void)moveStoryScrollViewToRight
{
    [parentController.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(parentController.view.mas_left).with.offset(ScreenWidth);
            make.right.equalTo(parentController.view.mas_right).with.offset(ScreenWidth);
        }];
        [parentController.view layoutIfNeeded];
    }completion:nil];
}

-(void)moveStoryScrollViewToLeft
{
    [parentController.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(parentController.view.mas_left).with.offset(-ScreenWidth);
            make.right.equalTo(parentController.view.mas_right).with.offset(-ScreenWidth);
        }];
        [parentController.view layoutIfNeeded];
    }completion:nil];
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
