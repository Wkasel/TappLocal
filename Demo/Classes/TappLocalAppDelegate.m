//
//  GameClockAppDelegate.m
//  GameClock
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import "TappLocalAppDelegate.h"
#import "TappLocalViewController.h"

@implementation TappLocalAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	[viewController setScreen:@"SCREEN_HOME":false];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    //const void *devTokenBytes = [devToken bytes];
   // self.registered = YES;
	
	//NSMutableString* deviceId = [NSMutableString string];
	//unsigned char* ptr = (unsigned char*) [devToken bytes];
	
	//for (NSInteger i=0; i<32; ++i)
	//{
	//	[deviceId appendString:[NSString stringWithFormat:@"%02x", ptr[i]]];
	//}

	//[RMSTracker saveString:@"deviceID":deviceId];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
   // NSLog(@"Error in registration. Error: %@", err);
	//[viewController showMessage:@"Error in registration"];
}


@end
