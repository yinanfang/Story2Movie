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
@synthesize previousStoryImageView, storyImageRightMostConstraint;
@synthesize storyScrollViewPanGesture, storyScrollViewPanVelecity;

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
        storyCount = [[[GCAppConfig sharedInstance] defaultStoryCount] integerValue];
        storyImageViews = [[NSMutableArray alloc] init];
        StoryImageWidth = [[GCAppConfig sharedInstance] StoryImageWidth];
        StoryImageHeight = [[GCAppConfig sharedInstance] StoryImageHeight];
        
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
            [GCAppConfig sharedInstance].StoryImageWidth = [newWidth floatValue];
            DDLogVerbose(@"RAC updated [AppConfig sharedInstance].StoryImageWidth to %f", [GCAppConfig sharedInstance].StoryImageWidth);
        }];
        [RACObserve(self, StoryImageHeight) subscribeNext:^(NSNumber *newHeight){
            [GCAppConfig sharedInstance].StoryImageHeight = [newHeight floatValue];
            DDLogVerbose(@"RAC updated [AppConfig sharedInstance].StoryImageHeight to %f", [GCAppConfig sharedInstance].StoryImageHeight);
        }];
        
        DDLogVerbose(@"Init StoryScrollView: %li; Story Count: %li", (long)ScrollerNumber, (long)storyCount);
    }
    return self;
}

-(void)setupBlankStoryScrollView
{
    // Prepare Blank Story Image with loading sign with shimmering effect
    previousStoryImageView = nil;
    for (int i = 0; i < storyCount; i++) {
        GCStoryItemView *imageView = [[GCStoryItemView alloc] initBlankStoryImageViewWithParentView:self storyNumber:i];
        [storyImageViews addObject:imageView];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(StoryImageHeight));
            make.width.equalTo(@(StoryImageHeight*(ScreenWidth/ScreenHeight)));
//            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(StoryImageWidth-2, StoryImageHeight)]);
            make.top.equalTo(self.mas_top);
        }];
        if (!previousStoryImageView) { // First one, pin to top
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(1);
            }];
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousStoryImageView.mas_right).offset(2);
            }];
        }
        if (i == storyCount-1) { // Last one, pin to right
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                storyImageRightMostConstraint = make.right.equalTo(self.mas_right).offset(-1);
            }];
        }
        previousStoryImageView = imageView;
    }
}

-(void)loadStoryScrollViewContent
{
    DDLogWarn(@"start loading story #%li", storyScrollerNumber);
    NSInteger defaultStoryCount = storyCount;
    NSString *keyPathForStoryCountInAppGeneral = [NSString stringWithFormat:@"bookCollection.%li.storyCount", storyScrollerNumber];
    storyCount = [[[[GCAppConfig sharedInstance] AppGeneral] valueForKeyPath:keyPathForStoryCountInAppGeneral] integerValue];
    if (storyCount != defaultStoryCount) {
        DDLogWarn(@"adding more story image view to count #%li", storyCount);
        [storyImageRightMostConstraint uninstall];
        for (int i = (int)defaultStoryCount; i < storyCount; i++) {
            GCStoryItemView *imageView = [[GCStoryItemView alloc] initBlankStoryImageViewWithParentView:self storyNumber:i];
            [storyImageViews addObject:imageView];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(StoryImageHeight));
                make.width.equalTo(@(StoryImageHeight*(ScreenWidth/ScreenHeight)));
                //            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(StoryImageWidth-2, StoryImageHeight)]);
                make.top.equalTo(self.mas_top);
            }];
            // Stick to the last image view
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousStoryImageView.mas_right).offset(2);
            }];
            if (i == storyCount-1) { // Last one, pin to right
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    storyImageRightMostConstraint = make.right.equalTo(self.mas_right).offset(-1);
                }];
            }
            previousStoryImageView = imageView;
        }
    }
    DDLogWarn(@"Loop through and call load method in image views");
    for (GCStoryItemView *storyImageView in storyImageViews) {
        [storyImageView loadStoryImage];
    }
    
    // Add Gesture Recognizer to the Story Scroll View
    [self addPanGestureRecognizerToView];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - Pan Gesture
- (void)addPanGestureRecognizerToView
{
    storyScrollViewPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidPan:)];
    storyScrollViewPanGesture.delegate = self;
    [self addGestureRecognizer:storyScrollViewPanGesture];
}
// First
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        DDLogWarn(@"StoryScrollView shoud receive touch!!!");
        return YES;
    }
    DDLogWarn(@"StoryScrollView shoud NOT receive touch!!!");
    return NO;
}
// Second
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == storyScrollViewPanGesture) {
        // Only respond to Vertical motion
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
        storyScrollViewPanVelecity = [panGesture velocityInView:parentController.view];
        if (fabsf(storyScrollViewPanVelecity.y) > fabsf(storyScrollViewPanVelecity.x)) {
            DDLogWarn(@"StoryScroll begins upward/freestyle motion!!!!!!");
            return YES;
        } else {
            DDLogWarn(@"Should not react!!!!!!");
            return NO;
        }
    }
    DDLogWarn(@"Should not begin");
    return YES;
}
// Third
- (void)gestureRecognizerDidPan:(UIPanGestureRecognizer*)panGesture {
    DDLogWarn(@"Panning Story Scroll View!!!!!!!!!");
    
}



#pragma mark - Story Scroll View Movement
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
