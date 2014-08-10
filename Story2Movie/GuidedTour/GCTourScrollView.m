//
//  TourScrollView.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCTourScrollView.h"

@implementation GCTourScrollView
@synthesize utility;
@synthesize tourImages_array, parentController, contentView;

- (id)initWithParentController:(UIViewController *)controller
{
    // Initialize Utility object
    utility = [[GCAppUtility alloc] init];
    parentController = controller;
    self = [super init];
    if (self) {
        // Add to parentController in order to place constrait
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        [self fetchImageViews];
        [parentController.view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(parentController.view);
        }];
    }
    return self;
}

-(void)setupTourScrollView
{
    UIImageView *previousImageView = nil;
    for (int i = 0; i < count_tourPages; i++) {
        UIImageView *imageView = [tourImages_array objectAtIndex:i];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(ScreenWidth, ScreenHeight)]);
            make.top.equalTo(self.mas_top);
        }];
        if (!previousImageView) { // First one, pin to top
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
            }];
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousImageView.mas_right);
            }];
        }
        if (i == count_tourPages-1) { // Last one, pin to right
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right);
            }];
        }else{
            previousImageView = imageView;
        }
    }
    
    
    
    
//    UIImageView *imageView = [tourImages_array objectAtIndex:0];
//    [self addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(ScreenWidth, ScreenHeight)]);
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left).offset(0);
//    }];
//    
//    UIImageView *imageView2 = [tourImages_array objectAtIndex:1];
//    [self addSubview:imageView2];
//    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(ScreenWidth, ScreenHeight)]);
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(imageView.mas_right).offset(0);
//    }];
//    
//    UIImageView *imageView3 = [tourImages_array objectAtIndex:2];
//    [self addSubview:imageView3];
//    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(ScreenWidth, ScreenHeight)]);
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(imageView2.mas_right).offset(0);
//        make.right.equalTo(self.mas_right);
//    }];
}

- (void)fetchImageViews
{
    tourImages_array = [[NSMutableArray alloc] init];
    for (int i = 0; i < count_tourPages; i++) {
        NSString *imageName = [NSString stringWithFormat:@"tour_%i", i];
        UIImageView *imageView = [utility getFullScreenImageView:imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 5;
//        imageView.layer.shadowOffset = CGSizeMake(0, 3);
//        imageView.layer.shadowRadius = 5.0;
//        imageView.layer.shadowColor = [UIColor clearColor].CGColor;
//        imageView.layer.shadowOpacity = 0.8;
        
        UIImageView *imageView_outer = [[UIImageView alloc] init];
        [imageView_outer addSubview: imageView];
        UIEdgeInsets padding = UIEdgeInsetsMake(1, 1, 1, 1);
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView_outer.mas_top).with.offset(padding.top);
            make.left.equalTo(imageView_outer.mas_left).with.offset(padding.left);
            make.bottom.equalTo(imageView_outer.mas_bottom).with.offset(-padding.bottom);
            make.right.equalTo(imageView_outer.mas_right).with.offset(-padding.right);
        }];
        [tourImages_array addObject:imageView_outer];
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
