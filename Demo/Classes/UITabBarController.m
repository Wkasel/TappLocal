//
//  DegradeTabBar.m
//  GameClock
//
//  Created by Guilherme Carvalho on 23/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "UITabBarController.h"


@implementation UITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 48);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[ColorUtils colorFromRGB:@"FF000"]];
    [v setAlpha:0.5];
    [[self tabBar] insertSubview:v atIndex:0];
    [v release];	
}



@end
