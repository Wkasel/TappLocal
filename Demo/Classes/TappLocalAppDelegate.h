//
//  GameClockAppDelegate.h
//  GameClock
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMSTracker.h"

@class TappLocalViewController;

@interface TappLocalAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TappLocalViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TappLocalViewController *viewController;

@end

