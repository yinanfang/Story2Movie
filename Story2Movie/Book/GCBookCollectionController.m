//
//  GCBookCollectionController.m
//  Story2Movie
//
//  Created by Golden Compass on 9/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookCollectionController.h"

@interface GCBookCollectionController ()

@end

@implementation GCBookCollectionController
@synthesize utility;
@synthesize manager;
@synthesize bookScrollView, bookPageControl;
@synthesize storyCollectionController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    DDLogInfo(@"====================  Entered main menu page  ====================");
    
    // Initialize Variables
    utility = [GCAppUtility sharedInstance];
    manager = [AFHTTPRequestOperationManager manager];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor clearColor];
    
    // Main init bank placer holder for book and story
    bookPageControl = [[GCBookPageControl alloc] initWithParentController:self];
    bookScrollView = [[GCBookScrollView alloc] initWithParentController:self];
    storyCollectionController = [[GCStoryCollectionController alloc] initWithParentController:self];
    [self addChildViewController:storyCollectionController];
    [self.view addSubview:storyCollectionController.view];
    [storyCollectionController didMoveToParentViewController:self];
    
    
    // Load App Content
    [self LoadAppContent];
    
}

-(void)LoadAppContent
{
    DDLogVerbose(@"Initial AppContent Dictionary: %@", [[GCAppConfig sharedInstance] AppGeneral]);
    
    NSString *url_string = [[NSString alloc] initWithFormat:@"%@/app_content/controller.php", [utility getCurrentDomain]];
    DDLogVerbose(@"url is: %@", url_string);
    NSDictionary *parameters = @{@"cmd": @"AppGeneral"};
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url_string parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDictionary) {
        DDLogInfo(@"Get data successfully. Printing response JSON: %@", responseDictionary);
        NSMutableDictionary *AppGeneral = [[GCAppConfig sharedInstance] AppGeneral];
        
        // Set bookCount
        NSNumber *newBookCount = [responseDictionary objectForKey:@"bookCount"];
        [AppGeneral setObject:newBookCount forKey:@"bookCount"];
        // Set bookCollection
        for (int i = 0; i < [newBookCount integerValue]; i++) {
            // Set book names
            NSString *keyPathForNewBookName = [NSString stringWithFormat:@"bookNames.%i", i];
            NSString *newBookName = [responseDictionary valueForKeyPath:keyPathForNewBookName];
            //            DDLogWarn(@"new book name: %@", newBookName);
            NSString *keyPathForBookNameInAppGeneral = [NSString stringWithFormat:@"bookCollection.%i.bookName", i];
            [AppGeneral setValue:newBookName forKeyPath:keyPathForBookNameInAppGeneral];
            
            // Set story image names
            NSString *keyPathForNewStoryImageNames = [NSString stringWithFormat:@"storyImageNames.%i", i];
            NSDictionary *newStoryImageNamesDictionary = [responseDictionary valueForKeyPath:keyPathForNewStoryImageNames];
            //            DDLogWarn(@"story image names: %@", newStoryImageNamesDictionary);
            NSString *keyPathForStoryImageNamesInAppGeneral = [NSString stringWithFormat:@"bookCollection.%i.storyImageNames", i];
            [AppGeneral setValue:newStoryImageNamesDictionary forKeyPath:keyPathForStoryImageNamesInAppGeneral];
            // Set story count
            NSNumber *storyCount = [NSNumber numberWithInteger:[[newStoryImageNamesDictionary allKeys] count]];
            NSString *keyPathForStoryCountInAppGeneral = [NSString stringWithFormat:@"bookCollection.%i.storyCount", i];
            [AppGeneral setValue:storyCount forKeyPath:keyPathForStoryCountInAppGeneral];
        }
        DDLogInfo(@"End AppContent Dictionary: %@", [[GCAppConfig sharedInstance] AppGeneral]);
        
        // Call child views' load method
        [bookScrollView loadBookScrollViewContent];
        [storyCollectionController loadStoryCollectionControllerContent];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Error: %@", error);
    }];
}

#pragma mark - General View Methods
// Hide the status bar on the tour page
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
