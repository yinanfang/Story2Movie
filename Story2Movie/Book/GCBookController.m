//
//  GCBookController.m
//  Story2Movie
//
//  Created by Golden Compass on 8/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCBookController.h"

@interface GCBookController ()

@end

@implementation GCBookController
@synthesize utility;
@synthesize bookScrollView, bookPageControl;
@synthesize storyController;
@synthesize manager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLogInfo(@"====================  Entered main menu page  ====================");
    
    // Initialization Variables
    utility = [GCAppUtility sharedInstance];
    manager = [AFHTTPRequestOperationManager manager];
    
    // Main init methods
    [self initAndSetupBookAndStory];
}

-(void)initAndSetupBookAndStory
{
    // Initialization
    bookScrollView = [[GCBookScrollView alloc] initWithParentController:self];
    bookPageControl = [[GCBookPageControl alloc] initWithParentController:self];
    storyController = [[GCStoryController alloc] initWithParentController:self];
    [self addChildViewController:storyController];
    [self.view addSubview:storyController.view];
    [storyController didMoveToParentViewController:self];
    
    // Blank Basic Setup
    [bookScrollView setupBlankBookScrollView];
    [bookPageControl setupBookPageControl];
    for (GCStoryScrollView *storyScroller in storyController.storyScrollViewArray) {
        [storyScroller setupBlankStoryScrollView];
    }
    
    // Load App Content
    [self LoadAppContent];
}

-(void)LoadAppContent
{
    DDLogWarn(@"Initial AppContent Dictionary: %@", [[AppConfig sharedInstance] AppGeneral]);
    
    NSString *url_string = [[NSString alloc] initWithFormat:@"%@/app_content/controller.php", [utility getCurrentDomain]];
    DDLogVerbose(@"url is: %@", url_string);
    NSDictionary *parameters = @{@"cmd": @"AppGeneral"};
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url_string parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DDLogVerbose(@"Printing response JSON: %@", responseObject);
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSMutableDictionary *AppGeneral = [[AppConfig sharedInstance] AppGeneral];
        
        // Set bookCount
        NSNumber *newBookCount = [responseDictionary objectForKey:@"bookCount"];
        [AppGeneral setObject:newBookCount forKey:@"bookCount"];
        // Set bookCollection
        NSDictionary *bookNames = [responseDictionary objectForKey:@"bookNames"];
        NSLog(@"bookNames: %@", bookNames);
        for (NSInteger i = 0; i < [newBookCount integerValue]; i++) {
//            NSString *bookName = [bookNames objectForKey:[NSString stringWithFormat:@"%li", i]];
//            NSDictionary *book = [[AppGeneral objectForKey:@"bookCollection"] objectForKey:[NSNumber numberWithInteger:i]];
//            NSMutableDictionary *mutableBook = [book mutableCopy];
//            [mutableBook setObject:bookName forKey:@"bookName"];
//            book = mutableBook;
            
            [[AppGeneral objectForKey:@"bookCollection"] objectForKey:[NSNumber numberWithInteger:i]];
        }
        
        
        
        DDLogWarn(@"End AppContent Dictionary: %@", [[AppConfig sharedInstance] AppGeneral]);
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
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}

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
