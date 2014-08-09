//
//  TourScrollView.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCTourScrollView.h"

@implementation GCTourScrollView
@synthesize tourImages_array, parentController, contentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImageArray:(NSMutableArray *)img_arr ParentController:(UIViewController *)controller
{
    tourImages_array = img_arr;
    parentController = controller;
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        // Initialization code
        
        
        
        
        UIImageView *imageView = [tourImages_array objectAtIndex:0];
        //            image.frame = CGRectMake((i)*320, 0, 320, 568);
        imageView.layer.cornerRadius = 5;
        imageView.bounds = CGRectInset(imageView.frame, 1.0f, 0.0f);
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(30);
            make.left.equalTo(self.mas_left).offset(10);
            //make.right.equalTo(self.mainScrollView.right).offset(-10);// Doesn't work
            make.width.equalTo(self.mas_width).offset(-20);
            make.height.equalTo(@50);
            
        }];

        UIImageView *imageView2 = [tourImages_array objectAtIndex:1];
        //            image.frame = CGRectMake((i)*320, 0, 320, 568);
        imageView.layer.cornerRadius = 5;
        imageView.bounds = CGRectInset(imageView.frame, 1.0f, 0.0f);
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView2];

        [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.width.equalTo(self.mas_width).offset(-20);
            //make.right.equalTo(scrollView.right).offset(-10); // Doesn't work
            make.top.equalTo(imageView.mas_bottom).offset(10);
        }];
        
        
        
//        UIEdgeInsets padding2 = UIEdgeInsetsMake(0, 100, 0, 420);
//        [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(ScreenSize);
//            make.top.equalTo(self.mas_top).with.offset(padding2.top); //with is an optional semantic filler
//            make.left.equalTo(imageView2.mas_right).with.offset(padding2.left);
//            make.right.equalTo(self.mas_right).width.offset(-padding2.right);
//            
//        }];
        


        
        
//        for (int i = 0; i < count_tourPages; i++) {
//            UIImageView *imageView = [tourImages_array objectAtIndex:i];
////            image.frame = CGRectMake((i)*320, 0, 320, 568);
//            imageView.layer.cornerRadius = 5;
//            imageView.bounds = CGRectInset(imageView.frame, 1.0f, 0.0f);
//            imageView.layer.masksToBounds = YES;
//            [self addSubview:imageView];
//
//            UIEdgeInsets padding = UIEdgeInsetsMake(0, 200, 0, 0);
//            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.mas_top).with.offset(padding.top); //with is an optional semantic filler
//                make.left.equalTo(self.mas_left).with.offset(padding.left);
//                make.bottom.equalTo(self.mas_bottom).with.offset(-padding.bottom);
//                make.right.equalTo(self.mas_right).with.offset(-padding.right);
//                make.size.mas_equalTo(ScreenSize);
//            }];
//        }

        
        
        
    }
    return self;
}

//    UIView *beeView = [[[NSBundle mainBundle] loadNibNamed:@"BeeView" owner:nil options:nil] firstObject];
//    beeView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.scrollView addSubview:beeView];
//
//    NSDictionary *views = @{@"beeView":beeView};
//    NSDictionary *metrics = @{@"height" : @600, @"width" : @900};
//    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
//    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
