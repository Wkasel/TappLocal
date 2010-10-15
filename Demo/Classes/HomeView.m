//
//  PastView.m
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "HomeView.h"
#import "TappLocalViewController.h"

@implementation HomeView

-(void) configure:(UIViewController*) parent
{
	controller = parent;
	
	if (!isBuilt)
	{
		isBuilt = true;

		mother = [[UIView alloc]init];
		mother.frame = CGRectMake(0, 0, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 320, 480)];
	//	bg.image = [UIImage imageWithData:[NSData dataWithBytesNoCopy:nearbyBytes length:nearbyLength freeWhenDone:NO]];
		[mother addSubview:bg];
	}
	
	[tl release];
	tl = [[TappLocalAPI alloc] initWithViewController: parent: @"526772_1"];
	[tl setRefreshTimeNewAds:60];
	[tl start];
	
	[controller.view addSubview:mother];
}



@end
