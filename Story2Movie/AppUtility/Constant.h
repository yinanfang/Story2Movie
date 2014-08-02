//
//  Constant.h
//  Story2Movie
//
//  Created by Golden Compass on 8/1/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define ScreenWidth 320
#define ScreenHeight 568

#define SWIPE_UP_THRESHOLD -400.0f
#define SWIPE_DOWN_THRESHOLD 400.0f
#define SWIPE_LEFT_THRESHOLD -400.0f
#define SWIPE_RIGHT_THRESHOLD 400.0f

#define SWIPE_VELOCITY_THRESHOLD 0.278F

FOUNDATION_EXPORT NSString *const HasShownTour;






@interface Constant : NSObject

@end
