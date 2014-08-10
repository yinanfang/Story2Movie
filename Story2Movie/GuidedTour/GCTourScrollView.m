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
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor blackColor];
        [self setContentOffset:CGPointFromString(@"200")];
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
            [self addStartButtonOnImageView:imageView];
        }else{
            previousImageView = imageView;
        }
    }
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

-(void)addStartButtonOnImageView:(UIImageView *)lastImageView
{
    UIButton *btn_start = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_start setTitle:@"Start" forState:UIControlStateNormal];
    btn_start.titleLabel.font = [UIFont fontWithName:@"Arial" size:30.0];
    btn_start.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn_start.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [btn_start setTintColor:[utility colorWithRGBAinHex:0xE0E0E0FF]];
    [btn_start addTarget:self action:@selector(enterMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    btn_start.layer.borderWidth = 3.0f;
    btn_start.layer.borderColor = [utility colorWithRGBAinHex:0xE0E0E0FF].CGColor;
    btn_start.layer.cornerRadius = 20.0f;
    [self addSubview:btn_start]; //TODO: add to lastImage? response chain
    [btn_start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 50)]);
        make.bottom.equalTo(lastImageView.mas_bottom).offset(-70);
        make.right.equalTo(lastImageView.mas_right).offset(-110);
    }];
    

}

-(void)enterMenuViewController
{
    NSLog(@"Pressed Start button...");
    [parentController presentViewController:[[GCGalleryViewController alloc] init] animated:YES completion:nil];
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
