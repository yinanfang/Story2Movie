//
//  GuidedTourViewController.m
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GuidedTourViewController.h"

@interface GuidedTourViewController ()

@end

@implementation GuidedTourViewController
@synthesize utility;
@synthesize tourImages_array, tourScrollView, tourPageControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogInfo(@"====================  Entered tour page  ====================");
    // Initialize Utility object
    utility = [[AppUtility alloc] init];
        
    tourImages_array = [[NSMutableArray alloc] init];
    for (int i = 0; i < count_tourPages; i++) {
        NSString *imageName = [NSString stringWithFormat:@"tour_%i", i];
        UIImageView *imageView = [utility getFullScreenImageView:imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [tourImages_array addObject:imageView];
        
        
        
//        UIImage *image =[utility getFullScreenImage:imageName];
//        NSLog(@"size: %@", NSStringFromCGSize(image.size));
//        CGFloat sdf = image.size.height;
//        CGFloat fds = image.size.width;
//        [tourImages_array addObject:[utility getFullScreenImage:imageName]];

    }
    
    
    
    
    
//    UIView *beeView = [[[NSBundle mainBundle] loadNibNamed:@"BeeView" owner:nil options:nil] firstObject];
//    beeView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.scrollView addSubview:beeView];
//    
//    NSDictionary *views = @{@"beeView":beeView};
//    NSDictionary *metrics = @{@"height" : @600, @"width" : @900};
//    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
//    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    
}


// Hide the status bar on the tour page
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UIViewController Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
