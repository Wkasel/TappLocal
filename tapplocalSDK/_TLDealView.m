//
//  UpcomingNormalView.m
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLDealView.h"
#import "_TL.h"
#import "offer_bg.png.h"
#import "merchant_logo.png.h"
#import "directions.png.h"
#import "no_thanks.png.h"
#import "more_deals.png.h"
#import "tap_to_use.png.h"
#import "already_used.png.h"

@implementation _TLDealView


-(void) configure:(id) parent
{
	tl = parent;
	
	coupon = [(_TL*)tl getCurrentCoupon];
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[_TLTappLocalView alloc]init];
		mother.frame = CGRectMake(0, 480, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		unsigned char* offerBytes = offer_bg_png;
		NSUInteger offerLength = offer_bg_png_len;
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, -20, 320, 480)];
		bg.image = [[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:offerBytes length:offerLength freeWhenDone:NO]];
		[mother addSubview:bg];
		
		top = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		top.barStyle = UIBarStyleBlackTranslucent;
		[mother addSubview:top];	
		
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
		UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Nearby Special"];
		item.rightBarButtonItem = rightButton;
		item.hidesBackButton = YES;
		[top pushNavigationItem:item animated:NO];
									
		special = [[UILabel alloc] initWithFrame:CGRectMake(22, 60, 274, 28)]; 
		special.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
		special.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		special.backgroundColor = nil;
		special.opaque = NO;
		special.textAlignment = UITextAlignmentCenter;
		[mother addSubview:special];
		
		unsigned char* merchantBytes = merchant_logo_png;
		NSUInteger merchantLength = merchant_logo_png_len;
		
		merchantlogoFrame = [[UIButton alloc] initWithFrame: CGRectMake(103, 95, 112, 120)];
		[merchantlogoFrame setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:merchantBytes length:merchantLength freeWhenDone:NO]] forState:UIControlStateNormal];
		[merchantlogoFrame addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogoFrame];
		
		merchantlogo = [[UIButton alloc] initWithFrame: CGRectMake(109, 108, 100, 100)];
		[merchantlogo addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogo];		
		
		text1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 226, 250, 70)];
		text1.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
		text1.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text1.backgroundColor = nil;
		text1.opaque = NO;
		text1.textAlignment = UITextAlignmentCenter;
		text1.numberOfLines = 3;
		[mother addSubview:text1];
		
		text2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 300, 250, 20)];
		text2.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
		text2.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text2.backgroundColor = nil;
		text2.opaque = NO;
		text2.textAlignment = UITextAlignmentCenter;
		[mother addSubview:text2];
		
		text3 = [[UILabel alloc] initWithFrame:CGRectMake(35, 322, 250, 20)]; 
		text3.font = [UIFont fontWithName:@"HelveticaNeue" size:10.0f];
		text3.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text3.backgroundColor = nil;
		text3.opaque = NO;
		text3.textAlignment = UITextAlignmentCenter;
		[mother addSubview:text3];
		
		unsigned char* directionsBytes = directions_png;
		NSUInteger directionsLength = directions_png_len;
		
		directions = [[UIButton alloc] initWithFrame: CGRectMake(37, 355, 78, 31)];
		[directions setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:directionsBytes length:directionsLength freeWhenDone:NO]] forState:UIControlStateNormal];
		[directions addTarget:self action:@selector(directionsClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:directions];
		
		unsigned char* noThanksBytes = no_thanks_png;
		NSUInteger noThanksLength = no_thanks_png_len;
		
		nothanks = [[UIButton alloc] initWithFrame: CGRectMake(115, 355, 82, 31)];
		[nothanks setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:noThanksBytes length:noThanksLength freeWhenDone:NO]] forState:UIControlStateNormal];
		[nothanks addTarget:self action:@selector(noThanksClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:nothanks];
		
		unsigned char* moreBytes = more_deals_png;
		NSUInteger moreLength = more_deals_png_len;
		
		moredeals = [[UIButton alloc] initWithFrame: CGRectMake(197, 355, 84, 31)];
		[moredeals setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:moreBytes length:moreLength freeWhenDone:NO]] forState:UIControlStateNormal];
		[moredeals addTarget:self action:@selector(moreDealsClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:moredeals];
		
		unsigned char* tappBytes = tap_to_use_png;
		NSUInteger tappLength = tap_to_use_png_len;
		
		taptouse = [[UIButton alloc] initWithFrame: CGRectMake(50, 398, 220, 37)];
		[taptouse setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:tappBytes length:tappLength freeWhenDone:NO]] forState:UIControlStateNormal];
		[taptouse addTarget:self action:@selector(tapToUseClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:taptouse];
		
		text4 = [[UILabel alloc] initWithFrame:CGRectMake(35, 433, 250, 20)];
		text4.font = [UIFont fontWithName:@"HelveticaNeue" size:8.0f];
		text4.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text4.backgroundColor = nil;
		text4.opaque = NO;
		text4.textAlignment = UITextAlignmentCenter;
		text4.text = @"*MUST TAP \"TAP TO USE\" IN ORDER FOR OFFER TO BE VALID";
		[mother addSubview:text4];
		
		text5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 449, 280, 12)];
		text5.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
		text5.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text5.backgroundColor = nil;
		text5.opaque = NO;
		text5.textAlignment = UITextAlignmentRight;
		text5.text = @"Ads by TappLocal";
		[mother addSubview:text5];
	}
	
	unsigned char* tappBytes = tap_to_use_png;
	NSUInteger tappLength = tap_to_use_png_len;
	
	unsigned char* alreadyBytes = already_used_png;
	NSUInteger alreadyLength = already_used_png_len;
	
	if ([_TLRMSTracker loadSafeString:[NSString stringWithFormat:@"%i_%i",TL_ACTION_USED_OK,coupon.idcoupon]] == nil)
		[taptouse setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:tappBytes length:tappLength freeWhenDone:NO]] forState:UIControlStateNormal];
	else
		[taptouse setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:alreadyBytes length:alreadyLength freeWhenDone:NO]] forState:UIControlStateNormal];
	
	[merchantlogo setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:coupon.logo]] forState:UIControlStateNormal];
	special.text = coupon.title;
	special.adjustsFontSizeToFitWidth = TRUE;
	
	text1.text = coupon.text;
	text1.adjustsFontSizeToFitWidth = TRUE;
	
	text2.text = coupon.dates;
	text2.adjustsFontSizeToFitWidth = TRUE;
	
	text3.text = coupon.location;
	text3.adjustsFontSizeToFitWidth = TRUE;

	mother.frame = CGRectMake(0, 480, 320, 480);
		
	[UIView beginAnimations:nil context:NULL]; 
	{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
		
		mother.frame = CGRectMake(0, 0, 320, 480);
			
	} [UIView commitAnimations];
	
	[((_TL*)tl).vc.view addSubview:mother];
}

-(void) merchantClick
{
	[(_TL*)tl setScreen:@"SCREEN_STORE":false];
}

-(void) tapToUseClick
{
	double d = [(_TL*)tl getDistanceFromStore];
	
	if (d < 0.1)
	{
		unsigned char* alreadyBytes = already_used_png;
		NSUInteger alreadyLength = already_used_png_len;
		
		[taptouse setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:alreadyBytes length:alreadyLength freeWhenDone:NO]] forState:UIControlStateNormal];
		[(_TL*)tl setScreen:@"SCREEN_CONFIRMED":false];
	}
	else
	{
		[(_TL*)tl sendLog:TL_ACTION_USED_FAR:nil];
		UIAlertView* tooFarView = [[UIAlertView alloc] initWithTitle:@"Too far from the store!"
															 message:[NSString stringWithFormat:@"You need to get closer to the store to use the coupon.",d]  
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil , nil];
		
		[tooFarView show];
		
	}
}

-(void) directionsClick
{
	[(_TL*)tl setScreen:@"SCREEN_SINGLEMAP":false];
}

-(void) moreDealsClick
{
	[(_TL*)tl setScreen:@"SCREEN_MAP":false];
}

-(void) noThanksClick
{
	[_TLRMSTracker saveString:[NSString stringWithFormat:@"coupon_%i",coupon.idcoupon] :@"no"];
	[(_TL*)tl sendLog:TL_ACTION_NO_THANKS:nil];
	[(_TL*)tl closeCoupons];	
}

-(void) closeClick
{
	[(_TL*)tl sendLog:TL_ACTION_CLOSE:nil];
	
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
	[(_TL*)tl closeCoupons];	
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
	[nothanks release];
	[moredeals release];
	[taptouse release];
	[text4 release];
	[text5 release];
	
	[super dealloc];
}

@end
