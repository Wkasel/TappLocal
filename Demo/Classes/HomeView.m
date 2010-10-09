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
		bg.image = [[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"bg.png"]];
		[mother addSubview:bg];
		
		logo = [[UIImageView alloc] initWithFrame: CGRectMake(5, 20, 309, 66)];
		logo.image = [[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"logo.png"]];
		[mother addSubview:logo];
		
		text = [[FontLabel alloc] initWithFrame:CGRectMake(10, 100, 300, 70) fontName:@"HelveticaNeue" pointSize:17.0f];
		text.textColor = [_TLColorUtils colorFromRGB:@"4B566C"];
		text.backgroundColor = nil;
		text.opaque = NO;
		text.textAlignment = UITextAlignmentCenter;
		text.lineBreakMode = UILineBreakModeCharacterWrap;
		text.numberOfLines = 4;
		text.text = @"This is a sample application that demon-   strates the abilities of the TappLocal         HyperLocal Advertising Platform.      For more information please contact";
		[mother addSubview:text];
			
		link = [[FontLabel alloc] initWithFrame:CGRectMake(10, 170, 300, 20) fontName:@"HelveticaNeue" pointSize:17.0f];
		link.textColor = [_TLColorUtils colorFromRGB:@"4B566C"];
		link.backgroundColor = nil;
		link.opaque = NO;
		link.textAlignment = UITextAlignmentCenter;
		link.text = @"support@tapplocal.com";
		link.userInteractionEnabled = TRUE;

		[mother addSubview:link];
		
		underline = [[UIView alloc]init];
		underline.frame = CGRectMake(73, 188, 174, 1);
		underline.backgroundColor = [_TLColorUtils colorFromRGB:@"4B566C"];
		[mother addSubview:underline];
		
		button = [[UIButton alloc]initWithFrame:CGRectMake(10, 170, 300, 20)];
		button.backgroundColor = [UIColor clearColor];
		[button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:button];	
		
		boxtext = [[FontLabel alloc] initWithFrame:CGRectMake(12, 382, 296, 40) fontName:@"HelveticaNeue" pointSize:7.0f];
		boxtext.textColor = [_TLColorUtils colorFromRGB:@"000000"];
		boxtext.backgroundColor = nil;
		boxtext.opaque = NO;
		boxtext.textAlignment = UITextAlignmentCenter;
		boxtext.text = @"Private & Confidential. This is a demo meant only for TappLocal Partners, advertisers, and press.";
		[mother addSubview:boxtext];
	}
	
	[tl release];
	tl = [[TappLocalAPI alloc] initWithViewController: parent];
	[tl setRefreshTimeNewAds:60];
	[tl start];
	
	[controller.view addSubview:mother];
}

-(void) action
{
/*	if (tl.running)
		[tl stop];
	else
		[tl start];*/
}

@end
