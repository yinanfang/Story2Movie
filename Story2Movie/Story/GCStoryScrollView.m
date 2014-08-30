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
@synthesize manager, scrollerNumber, storyCount, StoryImageHeight, StoryImageWidth;
@synthesize storyNames, storyImageViews;

#pragma mark - Blank Frame Initialization
-(id)initWithParentController:(GCStoryController *)controller ScrollerNumber:(NSInteger)ScrollerNumber
{
    self = [super init];
    if (self) {
        // Get Utility object
        utility = [GCAppUtility sharedInstance];
        
        // Initialization Variables
        parentController = controller;
        manager = [AFHTTPRequestOperationManager manager];
        scrollerNumber = ScrollerNumber;
        storyCount = [[[[AppConfig sharedInstance] storyCountDictionary] objectForKey:[NSString stringWithFormat:@"%li", scrollerNumber]] integerValue];
        StoryImageWidth = [[AppConfig sharedInstance] StoryImageWidth];
        StoryImageHeight = [[AppConfig sharedInstance] StoryImageHeight];
        
        // Empty Frame Initialization
        self.pagingEnabled = NO;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        [parentController.view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(parentController.view);
        }];
        
        // Observe value changes
        [RACObserve(self, storyCount) subscribeNext:^(NSNumber *newStoryCount){
            NSMutableDictionary *storyCountDictionary = [[AppConfig sharedInstance] storyCountDictionary];
            [storyCountDictionary setValue:[NSNumber numberWithInteger:storyCount] forKey:[NSString stringWithFormat:@"%li", ScrollerNumber]];
        }];
    
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
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(StoryImageWidth-2, StoryImageHeight)]);
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
