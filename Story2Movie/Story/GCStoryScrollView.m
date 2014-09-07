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
@synthesize manager, storyScrollerNumber, storyCount, StoryImageHeight, StoryImageWidth, StoryImageWidth_Standard, StoryImageHeight_Standard;
@synthesize ScreenHeightAdjustedForImage, ScreenWidthAdjustedForImage;
@synthesize storyNames, storyItemViews;
@synthesize previousStoryImageView, storyImageRightMostConstraint, storyImageLeftMostConstraint;
@synthesize storyScrollViewVerticalPanGesture;
@synthesize newStoryImageHeight, newStoryImageWidth;
@synthesize storyScrollViewPanVelecity, storyScrollViewPanTranslation, touchPointInScrollView, touchPointInStoryController;
@synthesize percentageOfWidthInOldItem, oldStoryControllerViewOffsetX, oldScrollViewConstraintOffsetX, newScrollViewConstraintOffsetX, numberOfStoryItemBeforeTheItemTouch;
@synthesize storyScrollViewPositionMode;

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
        storyItemViews = [[NSMutableArray alloc] init];
        StoryImageWidth = [[GCAppConfig sharedInstance] StoryImageWidth];
        StoryImageHeight = [[GCAppConfig sharedInstance] StoryImageHeight];
        StoryImageHeight_Standard = [[GCAppConfig sharedInstance] StoryImageHeight_Standard];
        StoryImageWidth_Standard = [[GCAppConfig sharedInstance] StoryImageWidth_Standard];
        ScreenHeightAdjustedForImage = [[GCAppConfig sharedInstance] ScreenHeightAdjustedForImage];
        ScreenWidthAdjustedForImage = [[GCAppConfig sharedInstance] ScreenWidthAdjustedForImage];
        storyScrollViewPositionMode = StoryScrollViewPositionFloat;
        
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
        [RACObserve(self, storyScrollViewPositionMode) subscribeNext:^(NSNumber *newHeight){
            if ([newHeight integerValue] == StoryScrollViewPositionFloat) {
                [GCAppConfig sharedInstance].storyScrollViewPositionMode = StoryScrollViewPositionFloat;
                DDLogVerbose(@"RAC updated [GCAppConfig sharedInstance].storyScrollViewPositionMode to StoryScrollViewPositionFloat");
            } else if ([newHeight integerValue] == StoryScrollViewPositionFullScreen) {
                [GCAppConfig sharedInstance].storyScrollViewPositionMode = StoryScrollViewPositionFullScreen;
                DDLogVerbose(@"RAC updated [GCAppConfig sharedInstance].storyScrollViewPositionMode to StoryScrollViewPositionFullScreen");
            }
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
        [storyItemViews addObject:imageView];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(StoryImageHeight_Standard));
            make.width.equalTo(@(StoryImageWidth_Standard));
//            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(StoryImageWidth-2, StoryImageHeight)]);
            make.top.equalTo(self.mas_top);
        }];
        if (!previousStoryImageView) { // First one, pin to top
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                storyImageLeftMostConstraint = make.left.equalTo(self.mas_left).offset(1);
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
            [storyItemViews addObject:imageView];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(StoryImageHeight_Standard));
                make.width.equalTo(@(StoryImageWidth_Standard));
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
    for (GCStoryItemView *storyImageView in storyItemViews) {
        [storyImageView loadStoryImage];
    }
    
    // Add Gesture Recognizer to the Story Scroll View
    [self addPanGestureRecognizerToView];
}

// Allowing multiple gesture recognizer to work together
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - Pan Gesture
- (void)addPanGestureRecognizerToView
{
    storyScrollViewVerticalPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidPan:)];
    storyScrollViewVerticalPanGesture.delegate = self;
    [self addGestureRecognizer:storyScrollViewVerticalPanGesture];
}
// First
// Two default gesture recognizer will be auto-pass into: UIScrollViewDelayedTouchesBeganGestureRecognizer, UIScrollViewPanGestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // Handle customized gesture recognizer
    if (gestureRecognizer == storyScrollViewVerticalPanGesture) {
        DDLogVerbose(@"ShouldReceiveTouch allowing customed recognizer - %@", [gestureRecognizer description]);
        return YES;
    }
    
    // Handle default gesture recognizer
    DDLogVerbose(@"ShouldReceiveTouch allowing default recognizer - %@", [gestureRecognizer description]);
    return YES;
}
// Second
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // Handle customized gesture recognizer
    if (gestureRecognizer == storyScrollViewVerticalPanGesture) {
        // Only respond to Vertical motion
        storyScrollViewPanVelecity = [storyScrollViewVerticalPanGesture velocityInView:parentController.view];
        if (fabsf(storyScrollViewPanVelecity.y) > fabsf(storyScrollViewPanVelecity.x)) {
            DDLogVerbose(@"StoryScrollView begins upward/freestyle motion!!!");
            return YES;
        } else {
            DDLogVerbose(@"StoryScrollView ignores unwanted horizontal motion!!!");
            return NO;
        }
    }
    
    // Handle default gesture recognizer
    DDLogVerbose(@"ShouldBegin allowing default recognizer - %@", [gestureRecognizer description]);
    return YES;
}
// Third
- (void)gestureRecognizerDidPan:(UIPanGestureRecognizer*)panGesture {
    storyScrollViewPanTranslation = [panGesture translationInView:parentController.view];
    CGFloat oldStoryImageHeight = StoryImageHeight;
    newStoryImageHeight = StoryImageHeight + (-storyScrollViewPanTranslation.y);
    CGFloat oldStoryImageWidth = StoryImageWidth;
    newStoryImageWidth = newStoryImageHeight*(ScreenWidth/ScreenHeight)-2;
    touchPointInScrollView = [panGesture locationInView:self];
    touchPointInStoryController = [panGesture locationInView:self.parentController.view];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        DDLogWarn(@"Start panning Story Scroll View...");
        oldScrollViewConstraintOffsetX = self.contentOffset.x;
        numberOfStoryItemBeforeTheItemTouch = floor(touchPointInScrollView.x/StoryImageWidth);
        DDLogWarn(@"======================================================================");
        DDLogWarn(@"oldContentOffsetX: %f - numberOfStoryItemBeforeTheItemTouch: %f", oldScrollViewConstraintOffsetX, numberOfStoryItemBeforeTheItemTouch);
    }
    newScrollViewConstraintOffsetX = oldScrollViewConstraintOffsetX+(-storyScrollViewPanTranslation.x);
    DDLogVerbose(@"00: %@ - 01: %f", [NSValue valueWithCGPoint:touchPointInScrollView], newScrollViewConstraintOffsetX);
    
    
    
    // Adjust scroll view offset
    [storyItemViews[0] mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).offset(-newScrollViewConstraintOffsetX);
    }];
    [super updateConstraints];
    // Change the controller height
    [parentController.view mas_updateConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@(newStoryImageHeight));
    }];
    [super updateConstraints];

//    self.contentOffset = CGPointMake(self.contentOffset.x-storyScrollViewPanTranslation.x, 0);

    
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        DDLogWarn(@"End panning Story Scroll View...");
        
        // Update Height and Width in this class and AppConfig
        self.StoryImageHeight = newStoryImageHeight; // RAC
        
        self.contentOffset = CGPointMake(newScrollViewConstraintOffsetX, 0);
        // Adjust scroll view offset
        [storyItemViews[0] mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.mas_left);
        }];
        [super updateConstraints];
        
        DDLogWarn(@"end ContentOffsetX: %f - ", newScrollViewConstraintOffsetX);
    }
    
//    percentageOfWidthInOldItem = (touchPointInScrollView.x-numberOfStoryItemBeforeTheItemTouch*oldStoryImageWidth)/oldStoryImageWidth;
//    newScrollViewConstraintOffsetX = numberOfStoryItemBeforeTheItemTouch*newStoryImageWidth + percentageOfWidthInOldItem*newStoryImageWidth - touchPointInStoryController.x;
//    DDLogVerbose(@"temp ttt: %f", touchPointInScrollView.x);
//    DDLogVerbose(@"temp percentageOfWidthInOldItem: %f", percentageOfWidthInOldItem);
////    DDLogVerbose(@"temp result01: %f", storyScrollViewPanTranslation.y);
////    DDLogVerbose(@"temp result02: %f", percentageOfWidthInOldItem);
////    DDLogVerbose(@"temp result03: %f", numberOfStoryItemBeforeTheItemTouch*newStoryImageWidth);
////    DDLogVerbose(@"temp result04: %f", percentageOfWidthInOldItem*newStoryImageWidth);
//    DDLogWarn(@"newScrollViewConstraintOffsetX: %f", newScrollViewConstraintOffsetX);
//    
//
////    parentController.view.frame = CGRectMake(0, ScreenHeight-newStoryImageHeight, ScreenWidth, newStoryImageHeight);
//    // Adjust scroll view offset
//    [storyItemViews[0] mas_updateConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(self.mas_left).offset(-newScrollViewConstraintOffsetX);
//    }];
//    [super updateConstraints];
//    // Change the controller height
//    [parentController.view mas_updateConstraints:^(MASConstraintMaker *make){
//        make.height.equalTo(@(newStoryImageHeight));
//    }];
//    // Change the image size for this scroll view. Update other when scroll to them
//    for (GCStoryItemView *storyItemView in self.storyItemViews) {
//        [storyItemView mas_updateConstraints:^(MASConstraintMaker *make){
//            make.height.equalTo(@(newStoryImageHeight));
//            make.width.equalTo(@(newStoryImageWidth));
//        }];
//    }
//    [super updateConstraints];
//    
//    // When gesture ends
//    if (panGesture.state == UIGestureRecognizerStateEnded) {
//        DDLogWarn(@"Gesture Ended - %@", [panGesture description]);
//        //        DDLogWarn(@"determinant: %f", newStoryImageHeight);
//        if (newStoryImageHeight > [[GCAppConfig sharedInstance] HeightDeterminant_FloatVSFullScreen]) {
//            DDLogWarn(@"should be full screen mode");
//            self.storyScrollViewPositionMode = StoryScrollViewPositionFullScreen; // RAC
//            newStoryImageHeight = ScreenHeight;
//            newStoryImageWidth = ScreenWidthAdjustedForImage;
////            [self enterOrRestoreScrollViewModeToFullScreen];
//        } else {
//            DDLogWarn(@"should be floating mode");
//            self.storyScrollViewPositionMode = StoryScrollViewPositionFloat;// RAC
//            newStoryImageHeight = StoryImageHeight_Standard;
//            newStoryImageWidth = StoryImageWidth_Standard;
////            [self enterOrRestoreScrollViewModeToFloat];
//        }
//        
//        
//        // Update Height and Width in this class and AppConfig
//        self.StoryImageHeight = newStoryImageHeight; // RAC
//        self.StoryImageWidth = newStoryImageWidth; // RAC
//        
//        DDLogWarn(@"final contentOffset: %f", self.contentOffset.x);
//    }
}

-(void)enterOrRestoreScrollViewModeToFullScreen
{
    DDLogVerbose(@"Updating the scroll view to full screen mode...");
    self.pagingEnabled = YES;
    [parentController.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // Change the controller height
        [parentController.view mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(@(newStoryImageHeight));
        }];
        // Adjust scroll view offset
        [storyItemViews[0] mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.mas_left).offset(1);
        }];
        // Change the image size for this scroll view. Update other when scroll to them
        for (GCStoryItemView *storyItemView in self.storyItemViews) {
            [storyItemView mas_updateConstraints:^(MASConstraintMaker *make){
                make.height.equalTo(@(newStoryImageHeight));
                make.width.equalTo(@(newStoryImageWidth));
            }];
        }
        [parentController.view layoutIfNeeded];
    }completion:nil];
    self.contentOffset = CGPointMake(numberOfStoryItemBeforeTheItemTouch*ScreenWidth, 0);
}

-(void)enterOrRestoreScrollViewModeToFloat
{
    DDLogVerbose(@"Updating the scroll view to float mode...");
    self.pagingEnabled = NO;
    [parentController.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // Change the controller height
        [parentController.view mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(@(newStoryImageHeight));
        }];
        // Adjust scroll view offset
        [storyItemViews[0] mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.mas_left).offset(1);
        }];
        // Change the image size for this scroll view. Update other when scroll to them
        for (GCStoryItemView *storyItemView in self.storyItemViews) {
            [storyItemView mas_updateConstraints:^(MASConstraintMaker *make){
                make.height.equalTo(@(newStoryImageHeight));
                make.width.equalTo(@(newStoryImageWidth));
            }];
        }
        [parentController.view layoutIfNeeded];
    }completion:nil];
    newScrollViewConstraintOffsetX = numberOfStoryItemBeforeTheItemTouch*StoryImageWidth_Standard + percentageOfWidthInOldItem*StoryImageWidth_Standard - touchPointInStoryController.x;
    if (newScrollViewConstraintOffsetX < 0) {// drag to the right. Blank on left side
        newScrollViewConstraintOffsetX = 0;
    } else if ((newScrollViewConstraintOffsetX+ScreenWidth)>self.contentSize.width) {// drag to the left. Blank on the right side
        newScrollViewConstraintOffsetX = StoryImageWidth_Standard*storyCount-ScreenWidth;
    }
    
    
    self.contentOffset = CGPointMake(newScrollViewConstraintOffsetX, 0);
}




//    DDLogVerbose(@"vertical translation: %f", storyScrollViewPanTranslation.y);
//    DDLogVerbose(@"newStoryImageHeight: %f", newStoryImageHeight);

// React to pan motion. Change Adjust the Story Item dynamically
//    parentController.view.frame.size.height = newStoryImageHeight;
//    parentController.view.frame = CGRectMake(0, oldStoryControllerViewFrame.origin.y+storyScrollViewPanTranslation.y, ScreenWidth, newStoryImageHeight);
//    for (GCStoryItemView *storyItemView in storyItemViews) {
//        //        storyItemView.frame = CGRectMake(newStoryImageWidth*storyItemView.storyNumber, 0, newStoryImageWidth, newStoryImageHeight);
//        [storyItemView mas_updateConstraints:^(MASConstraintMaker *make){
//            make.height.equalTo(@(newStoryImageHeight));
//            make.width.equalTo(@(newStoryImageWidth));
//        }];
//        [super updateConstraints];
//    }



//    CGPoint newContentOffset = CGPointMake(oldContentOffset.x+deltaContentOffset-storyScrollViewPanTranslation.x, self.contentOffset.y);
//    if (newContentOffset.x>0 | (self.contentSize.width-newContentOffset.x)>0) {
//        // When the story scroll view is in the middle
//        self.contentOffset = newContentOffset;
//    } else {
//        if (touchPointInScrollView.x < touchPointInStoryController.x) {
//            // When left edge reach in
//            DDLogError(@"left edge reach in");
//            self.contentOffset = CGPointZero;
//        } else if ((self.contentSize.width-touchPointInScrollView.x) < (ScreenWidth-touchPointInStoryController.x)){
//            // When right edge reach in
//            DDLogError(@"right edge reach in");
//            self.contentOffset = CGPointMake(newStoryImageWidth*storyCount-ScreenWidth, self.contentOffset.y);
//        }
//    }

//    if (touchPointInScrollView.x < touchPointInStoryController.x) {
//        // When left edge reach in
//        DDLogError(@"left edge reach in");
//        self.contentOffset = CGPointZero;
//    } else if ((self.contentSize.width-touchPointInScrollView.x) < (ScreenWidth-touchPointInStoryController.x)){
//        // When right edge reach in
//        DDLogError(@"right edge reach in");
//        self.contentOffset = CGPointMake(newStoryImageWidth*storyCount-ScreenWidth, self.contentOffset.y);
//    } else {
//        DDLogError(@"im the middle");
//        self.contentOffset = CGPointMake(oldContentOffset.x+deltaContentOffset-storyScrollViewPanTranslation.x, self.contentOffset.y);
//    }


//


// Update Height and Width in this class and AppConfig
//    self.StoryImageHeight = newStoryImageHeight; // RAC
//    self.StoryImageWidth = newStoryImageWidth; // RAC






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
