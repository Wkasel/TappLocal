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

		mother = [[UIScrollView alloc]init];
		mother.frame = CGRectMake(0, 0, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 320, 480)];
		bg.image = [[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"bg.png"]];
		[mother addSubview:bg];
		
		logo = [[UIImageView alloc] initWithFrame: CGRectMake(5, 20, 309, 66)];
		logo.image = [[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"logo.png"]];
		[mother addSubview:logo];
		
		text = [[FontLabel alloc] initWithFrame:CGRectMake(10, 100, 300, 70) fontName:@"HelveticaNeue" pointSize:17.0f];
		text.textColor = [ColorUtils colorFromRGB:@"4B566C"];
		text.backgroundColor = nil;
		text.opaque = NO;
		text.textAlignment = UITextAlignmentCenter;
		text.lineBreakMode = UILineBreakModeCharacterWrap;
		text.numberOfLines = 4;
		text.text = @"This is a sample application that demon-   strates the abilities of the TappLocal         HyperLocal Advertising Platform.      For more information please contact";
		[mother addSubview:text];
			
		link = [[FontLabel alloc] initWithFrame:CGRectMake(10, 170, 300, 20) fontName:@"HelveticaNeue" pointSize:17.0f];
		link.textColor = [ColorUtils colorFromRGB:@"4B566C"];
		link.backgroundColor = nil;
		link.opaque = NO;
		link.textAlignment = UITextAlignmentCenter;
		link.text = @"support@tapplocal.com";
		link.userInteractionEnabled = TRUE;

		[mother addSubview:link];
		
		underline = [[UIView alloc]init];
		underline.frame = CGRectMake(73, 188, 174, 1);
		underline.backgroundColor = [ColorUtils colorFromRGB:@"4B566C"];
		[mother addSubview:underline];
		
		button = [[UIButton alloc]initWithFrame:CGRectMake(10, 170, 300, 20)];
		button.backgroundColor = [UIColor clearColor];
		[button addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:button];	
		
		table = [[UITableView alloc] initWithFrame:CGRectMake(10, 200, 300, 100) style:UITableViewStyleGrouped];
		table.delegate = self;
		table.dataSource = self;
		table.backgroundColor = [UIColor clearColor];
		[mother addSubview:table];
		
		nearby = [[UIButton alloc] initWithFrame: CGRectMake(320, 115, 65, 39)];
		[nearby setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"nearby.png"]] forState:UIControlStateNormal];
		[nearby addTarget:self action:@selector(couponClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:nearby];
		
		flash = [[UIButton alloc] initWithFrame: CGRectMake(0, 460, 320, 35)];
		[flash setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"flash.png"]] forState:UIControlStateNormal];
		flash.hidden = true;
		flash.alpha = 0.6;
		[flash addTarget:self action:@selector(flashClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:flash];
		
		boxtext = [[FontLabel alloc] initWithFrame:CGRectMake(12, 382, 296, 40) fontName:@"HelveticaNeue" pointSize:7.0f];
		boxtext.textColor = [ColorUtils colorFromRGB:@"000000"];
		boxtext.backgroundColor = nil;
		boxtext.opaque = NO;
		boxtext.textAlignment = UITextAlignmentCenter;
		boxtext.text = @"Private & Confidential. This is a demo meant only for TappLocal Partners, advertisers, and press.";
		[mother addSubview:boxtext];
	}
	
	[controller.view addSubview:mother];
}

-(void) sendEmail
{
	NSString *url = [NSString stringWithString: @"mailto:support@tapplocal.com?subject=TappLocal"];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath indexAtPosition:1]  == 0)
	{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"0"];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"] autorelease];
		}
		
		cell.textLabel.text = @"Simulate Nearby Offer";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		return cell;
	}
	else
	{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
		}
		
		cell.textLabel.text = @"Simulate Flash Deal";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		return cell;		
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath indexAtPosition:1]  == 0)
	{
		movingNearbyIn = !movingNearbyIn;
		
		[UIView beginAnimations:nil context:NULL]; {
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:1.0];
			[UIView setAnimationDelegate:self];
			if (movingNearbyIn) 
			{
				nearby.frame = CGRectMake(255,  115, 65, 39);
			}
			else 
			{
				nearby.frame = CGRectMake(320,  115, 65, 39);	
			}

		} [UIView commitAnimations];
			
	}
	else 
	{
		movingFlashIn = !movingFlashIn;
		
		[UIView beginAnimations:nil context:NULL]; {
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:1.0];
			[UIView setAnimationDelegate:self];
			if (movingFlashIn) 
			{
				flash.frame = CGRectMake(0, 425, 320, 35);
				flash.hidden = FALSE;
				
				[UIView setAnimationRepeatCount:2.0];
				[UIView setAnimationRepeatAutoreverses:YES];
				
				flash.alpha = 1.0;
			}
			else 
			{
				flash.frame = CGRectMake(0, 460, 320, 35);
				flash.alpha = 0.6;
				flash.hidden = true;
			}
			
		} [UIView commitAnimations];
	}
}

-(void)couponClick
{
	//hide stuff
	nearby.frame = CGRectMake(320,  115, 65, 39);	
	movingNearbyIn = false;
	
	flash.frame = CGRectMake(0, 460, 320, 35);
	flash.alpha = 0.6;
	flash.hidden = true;
	movingFlashIn = false;
	
	[(TappLocalViewController*)controller setScreen:@"SCREEN_DEAL":false];
}

-(void)flashClick
{
	//hide stuff
	nearby.frame = CGRectMake(320,  115, 65, 39);	
	movingNearbyIn = false;
	
	flash.frame = CGRectMake(0, 460, 320, 35);
	flash.alpha = 0.6;
	flash.hidden = true;
	movingFlashIn = false;
	
	[(TappLocalViewController*)controller setScreen:@"SCREEN_FLASH":false];
}

@end
