//
//  GCStoryImageView.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCStoryItemView.h"
#import "GCStoryScrollView.h"

@implementation GCStoryItemView
@synthesize utility;
@synthesize parentView, storyNumber;
@synthesize manager;

-(id)initBlankStoryImageViewWithParentView:(GCStoryScrollView *)ParentView storyNumber:(NSInteger)number
{
    self = [super init];
    if (self) {
        // Initialization variables
        utility = [GCAppUtility sharedInstance];
        parentView = ParentView;
        storyNumber = number;
        manager = [AFHTTPRequestOperationManager manager];
        
        // Customize Book Image View
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;     
    }
    return self;
}

-(void)loadStoryImage
{
    NSString *imageKeyPath = [NSString stringWithFormat:@"bookCollection.%li.storyImageNames.%li", parentView.storyScrollerNumber, storyNumber];
    NSString *storyImageName = [[[GCAppConfig sharedInstance] AppGeneral] valueForKeyPath:imageKeyPath];
    NSString *url_string = [[NSString alloc] initWithFormat:@"%@/app_content/book/%li/story/%@%@", [utility getCurrentDomain], parentView.storyScrollerNumber, storyImageName,[[GCConstant sharedInstance] PNGTypeAndSuffix]];
    DDLogVerbose(@"url: %@", url_string);
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage *responsePNG) {
        DDLogVerbose(@"Image: %@", responsePNG);
        self.image = responsePNG;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Error: %@", error);
    }];
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
