//
//  GCBookView.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookController.h"
#import "GCBookView.h"

@implementation GCBookView
@synthesize utility;
@synthesize parentController;
@synthesize PixelAdjustForHorizontalGap;
@synthesize bookTitleView, bookTitleLabel;
@synthesize manager;

- (id)initWithParentController:(GCBookController *)controller
{
    
    self = [super init];
    if (self) {
        // Initialize Variables
        utility = [GCAppUtility sharedInstance];
        parentController = controller;
        PixelAdjustForHorizontalGap = [[GCAppConfig sharedInstance] PixelAdjustForHorizontalGap];
        manager = [AFHTTPRequestOperationManager manager];

        // Empty Frame Initialization
        self.frame = CGRectMake(PixelAdjustForHorizontalGap, 0, ScreenWidth-PixelAdjustForHorizontalGap*2, ScreenHeight);
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        // Add book title with shimmer effect
        bookTitleView = [[FBShimmeringView alloc] initWithFrame:[[GCAppConfig sharedInstance] BookTitleViewRect]];
        bookTitleView.shimmering = YES;
        bookTitleView.shimmeringBeginFadeDuration = 0.3;
        bookTitleView.shimmeringPauseDuration = 3;
        bookTitleView.shimmeringSpeed = 250;
        bookTitleView.shimmeringOpacity = 0.5;
        [self addSubview:bookTitleView];

        bookTitleLabel = [[UILabel alloc] init];
        bookTitleLabel.textAlignment = NSTextAlignmentCenter;
        bookTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        bookTitleLabel.textColor = [UIColor whiteColor];
        bookTitleLabel.backgroundColor = [UIColor clearColor];
        bookTitleLabel.textAlignment = NSTextAlignmentLeft;
        bookTitleLabel.text = @"Story2Movie";
        bookTitleView.contentView = bookTitleLabel;
        [parentController.view addSubview:self];
    }
    return self;
}

- (void)loadBookContent
{
    // Update book title
    NSString *bookNameKeyPath = [NSString stringWithFormat:@"bookCollection.%li.bookName", parentController.bookNumber];
    NSString *bookName = [[[GCAppConfig sharedInstance] AppGeneral] valueForKeyPath:bookNameKeyPath];
    bookTitleLabel.text = bookName;
    
    // Update book image
    NSString *url_string = [[NSString alloc] initWithFormat:@"%@/app_content/book/%li/cover%@", [utility getCurrentDomain], parentController.bookNumber, [[GCConstant sharedInstance] PNGTypeAndSuffix]];
    DDLogVerbose(@"url: %@", url_string);
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage *responsePNG) {
        DDLogVerbose(@"Retrieve book image: %@", responsePNG);
        // Change book view background color
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *bookImage = [[UIImageView alloc] initWithFrame:self.frame];
        bookImage.image = responsePNG;
        [self insertSubview:bookImage belowSubview:bookTitleView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Error: %@", error);
    }];
}

@end
