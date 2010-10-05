//
//  UpcomingNormalView.m
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLDealView.h"
#import "TappLocalViewController.h"
#import "TappLocal.h"

@implementation _TLDealView


-(void) configure:(id) parent
{
	tl = parent;
	
	coupon = [(TappLocal*)tl getCurrentCoupon];
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[_TLTappLocalView alloc]init];
		mother.frame = CGRectMake(0, 480, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, -20, 320, 480)];
		bg.image = [[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"offer_bg.png"]];
		[mother addSubview:bg];
		
		top = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		top.barStyle = UIBarStyleBlackTranslucent;
		[mother addSubview:top];	
		
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
		UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Nearby Special"];
		item.rightBarButtonItem = rightButton;
		item.hidesBackButton = YES;
		[top pushNavigationItem:item animated:NO];
									
		special = [[FontLabel alloc] initWithFrame:CGRectMake(22, 60, 274, 28) fontName:@"HelveticaNeue" pointSize:20.0f];
		special.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		special.backgroundColor = nil;
		special.opaque = NO;
		special.textAlignment = UITextAlignmentCenter;
		special.text = coupon.title;
		[mother addSubview:special];
		
		merchantlogoFrame = [[UIButton alloc] initWithFrame: CGRectMake(103, 95, 112, 120)];
		[merchantlogoFrame setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"merchant_logo.png"]] forState:UIControlStateNormal];
		[merchantlogoFrame addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogoFrame];
		
		merchantlogo = [[UIButton alloc] initWithFrame: CGRectMake(110, 110, 100, 100)];
		[merchantlogo setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:coupon.logo]] forState:UIControlStateNormal];
		[merchantlogo addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogo];		
		
		text1 = [[FontLabel alloc] initWithFrame:CGRectMake(35, 226, 250, 70) fontName:@"HelveticaNeue" pointSize:20.0f];
		text1.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text1.backgroundColor = nil;
		text1.opaque = NO;
		text1.textAlignment = UITextAlignmentCenter;
		text1.text = coupon.text;
		text1.numberOfLines = 3;
		[mother addSubview:text1];
		
		text2 = [[FontLabel alloc] initWithFrame:CGRectMake(35, 300, 250, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		text2.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text2.backgroundColor = nil;
		text2.opaque = NO;
		text2.textAlignment = UITextAlignmentCenter;
		text2.text = coupon.dates;
		[mother addSubview:text2];
		
		text3 = [[FontLabel alloc] initWithFrame:CGRectMake(35, 322, 250, 20) fontName:@"HelveticaNeue" pointSize:10.0f];
		text3.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text3.backgroundColor = nil;
		text3.opaque = NO;
		text3.textAlignment = UITextAlignmentCenter;
		text3.text = coupon.location;
		[mother addSubview:text3];
		
		directions = [[UIButton alloc] initWithFrame: CGRectMake(50, 355, 74, 31)];
		[directions setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"directions.png"]] forState:UIControlStateNormal];
		[directions addTarget:self action:@selector(directionsClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:directions];
		
		savedeal = [[UIButton alloc] initWithFrame: CGRectMake(124, 355, 74, 31)];
		[savedeal setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"save_deal.png"]] forState:UIControlStateNormal];
		[savedeal addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:savedeal];
		
		moredetails = [[UIButton alloc] initWithFrame: CGRectMake(198, 355, 74, 31)];
		[moredetails setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"more_details.png"]] forState:UIControlStateNormal];
		[moredetails addTarget:self action:@selector(moreDealsClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:moredetails];
		
		taptouse = [[UIButton alloc] initWithFrame: CGRectMake(50, 398, 220, 37)];
		[taptouse setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"tap_to_use.png"]] forState:UIControlStateNormal];
		[taptouse addTarget:self action:@selector(tapToUseClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:taptouse];
		
		text4 = [[FontLabel alloc] initWithFrame:CGRectMake(35, 433, 250, 20) fontName:@"HelveticaNeue" pointSize:8.0f];
		text4.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text4.backgroundColor = nil;
		text4.opaque = NO;
		text4.textAlignment = UITextAlignmentCenter;
		text4.text = @"*MUST TAP \"TAP TO USE\" IN ORDER FOR OFFER TO BE VALID";
		[mother addSubview:text4];
		
		text5 = [[FontLabel alloc] initWithFrame:CGRectMake(20, 449, 280, 12) fontName:@"HelveticaNeueBold" pointSize:12.0f];
		text5.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text5.backgroundColor = nil;
		text5.opaque = NO;
		text5.textAlignment = UITextAlignmentRight;
		text5.text = @"Ads by TappLocal";
		[mother addSubview:text5];
	}

	mother.frame = CGRectMake(0, 480, 320, 480);
		
	[UIView beginAnimations:nil context:NULL]; 
	{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
		
		mother.frame = CGRectMake(0, 0, 320, 480);
			
	} [UIView commitAnimations];
	
	[((TappLocal*)tl).vc.view addSubview:mother];
}

-(void) merchantClick
{
	[(TappLocal*)tl setScreen:@"SCREEN_STORE":false];
}

-(void) tapToUseClick
{
	[taptouse setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"already_used.png"]] forState:UIControlStateNormal];
	[(TappLocal*)tl setScreen:@"SCREEN_CONFIRMED":false];
}

-(void) directionsClick
{
	[(TappLocal*)tl setScreen:@"SCREEN_SINGLEMAP":false];
}

-(void) moreDealsClick
{
	[(TappLocal*)tl setScreen:@"SCREEN_MAP":false];
}

-(void) likeClick
{
	facebook = [[Facebook alloc]init];
	NSArray *permissions = [NSArray arrayWithObjects:@"email", nil]; //[NSArray arrayWithObjects:@"publish_stream", @"email", @"offline_access",  @"user_birthday",@"user_events", @"user_groups",  @"user_likes", @"user_location", @"user_online_presence", @"read_stream",  nil];
	[facebook authorize:@"bbbe5983d6af9dfdd721b34b1f41a020" permissions:permissions delegate:self];
}

- (void)fbDidLogin
{
	NSLog(@"logged!");
	[facebook requestWithGraphPath:@"me" andDelegate:self];
	[facebook logout:nil];
}

- (void)fbDidNotLogin
{
	NSLog(@"not logged");	
}

- (void)fbDidLogout
{
	NSLog(@"logout");	
}


- (void)request:(FBRequest*)request didLoad:(id)result;
{
	NSLog(@"%@",result);
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error
{
	NSLog(@"%@",error);
}

-(void) closeClick
{
	[UIView beginAnimations:nil context:NULL]; 
	{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector (animationDidStopClose:finished:context:) ];
		
		mother.frame = CGRectMake(0, 480, 320, 480);
		
	} [UIView commitAnimations];
}

- (void) animationDidStopClose:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[(TappLocal*)tl closeCoupons];	
}

-(void) removeFromSuperview
{
	[mother removeFromSuperview];
}

-(void) dealloc
{
	[mother release];
	[bg release];
	[top release];
	[close release];
	[special release];
	[merchantlogoFrame release];	
	[merchantlogo release];	
	[text1 release];
	[text2 release];
	[text3 release];
	[directions release];
	[savedeal release];
	[moredetails release];
	[taptouse release];
	[text4 release];
	[text5 release];
	[facebook release];	
	
	[super dealloc];
}

@end