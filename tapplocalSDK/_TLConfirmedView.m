//
//  ConfirmedView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLConfirmedView.h"
#import "_TL.h"
#import "confirmed.png.h"
#import "follow.png.h"
#import "unfollow.png.h"

@implementation _TLConfirmedView

-(void) configure:(id) parent
{
	tl = parent;
	
	coupon = [(_TL*)tl getCurrentCoupon];
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[_TLTappLocalView alloc]init];
		mother.frame = CGRectMake(20, 10, 281, 418);
		mother.backgroundColor = [_TLColorUtils colorFromRGB:@"CFE8F3"];
		
		unsigned char* confirmedBytes = confirmed_png;
		NSUInteger confirmedLength = confirmed_png_len;
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 281, 418)];
		bg.image = [[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:confirmedBytes length:confirmedLength freeWhenDone:NO]];
		[mother addSubview:bg];
		
		show = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 260, 20)];
		show.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
		show.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		show.backgroundColor = nil;
		show.opaque = NO;
		show.textAlignment = UITextAlignmentCenter;
		show.text = @"Please present this to the merchant!";		
		[mother addSubview:show];
		
		merchantlogo = [[UIButton alloc] initWithFrame: CGRectMake(100, 120, 80, 80)];
		[merchantlogo addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogo];		
		
		title = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 260, 20)];
		title.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
		title.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		title.backgroundColor = nil;
		title.opaque = NO;
		title.textAlignment = UITextAlignmentCenter;
		[mother addSubview:title];
		
		text1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 226, 260, 70)];
		text1.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
		text1.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text1.backgroundColor = nil;
		text1.opaque = NO;
		text1.textAlignment = UITextAlignmentCenter;
		text1.numberOfLines = 3;
		[mother addSubview:text1];
		
		text2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 260, 20)];
		text2.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
		text2.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text2.backgroundColor = nil;
		text2.opaque = NO;
		text2.textAlignment = UITextAlignmentCenter;
		
		[mother addSubview:text2];
		
		text3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 322, 260, 20)];
		text3.font = [UIFont fontWithName:@"HelveticaNeue" size:10.0f];
		text3.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text3.backgroundColor = nil;
		text3.opaque = NO;
		text3.textAlignment = UITextAlignmentCenter;
		[mother addSubview:text3];
		
		follow = [[UIButton alloc] initWithFrame: CGRectMake(30, 360, 220, 37)];
		[follow addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:follow];		
		
		close = [[UIButton alloc] initWithFrame: CGRectMake(220, 0, 60, 40)];
		[close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:close];
		
		tv = [[UITextField alloc] initWithFrame:CGRectMake(12,70,260,35)];
		tv.autocapitalizationType = UITextAutocapitalizationTypeNone;
		tv.autocorrectionType = UITextAutocorrectionTypeNo;
		tv.backgroundColor = [UIColor whiteColor];
		tv.returnKeyType = UIReturnKeyDone;
		tv.delegate = self;
		tv.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		tv.textAlignment = UITextAlignmentCenter;
		
		emailRegex =
		@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
		@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
		@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
		@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
		@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
		@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
		@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
		[emailRegex retain];
		emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
		[emailTest retain];
	}
	
	[merchantlogo setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:coupon.logo]] forState:UIControlStateNormal];
	title.text = coupon.title;
	text1.text = coupon.text;
	text2.text = coupon.dates;
	text3.text = coupon.location;
	
	bg.hidden = true;	
	show.hidden = true;
	merchantlogo.hidden = true;
	title.hidden = true;
	text1.hidden = true;
	text2.hidden = true;
	text3.hidden = true;
	follow.hidden = true;
	
	mother.frame = CGRectMake(160, 230, 0, 0);
	
	[UIView beginAnimations:nil context:NULL]; 
	{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidFinishOpen:finished:context:) ];
		
		mother.frame = CGRectMake(20, 10, 281, 418);	
		
	} [UIView commitAnimations];
	
	if ([_TLRMSTracker load:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]] != nil)
	{
		unsigned char* unfollowBytes = unfollow_png;
		NSUInteger unfollowLength = unfollow_png_len;
		
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:unfollowBytes length:unfollowLength freeWhenDone:NO]] forState:UIControlStateNormal];
		tv.text = [_TLRMSTracker loadSafeString:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]];
	}
	else
	{
		unsigned char* followBytes = follow_png;
		NSUInteger followLength = follow_png_len;
		
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:followBytes length:followLength freeWhenDone:NO]] forState:UIControlStateNormal];
	}
	
	[((_TL*)tl).vc.view addSubview:mother];
}

- (void) animationDidFinishOpen:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	bg.hidden = false;	
	show.hidden = false;
	merchantlogo.hidden = false;
	title.hidden = false;
	text1.hidden = false;
	text2.hidden = false;
	text3.hidden = false;
	follow.hidden = false;
}

-(void) seemoreClick
{
	[tl setScreen:@"SCREEN_MAP":false];
}

-(void) moreoffersClick
{
	[tl setScreen:@"SCREEN_MAP":false];	
}

-(void) closeClick
{
	[mother removeFromSuperview];
}

-(void) dealloc
{
	[mother release];
	[bg release];
	[merchantlogo release];
	[show release];
	[close release];
	[title release];
	[text1 release];
	[text2 release];	
	[text3 release];	
	[follow release];
	[tv release];
	[emailRegex release];
	[emailTest release];
	
	[super dealloc];
}

-(void)followClick
{
	if ([_TLRMSTracker load:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]] != nil)
	{
		NSString* old = [_TLRMSTracker loadSafeString:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]];
		[_TLRMSTracker deleteRecordstore:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]];

		unsigned char* followBytes = follow_png;
		NSUInteger followLength = follow_png_len;
		
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:followBytes length:followLength freeWhenDone:NO]] forState:UIControlStateNormal];
		
		[(_TL*)tl sendLog:TL_ACTION_UNFOLLOW:old];
	}
	else
	{
		UIAlertView* remindView = [[UIAlertView alloc] initWithTitle:@"Type your e-mail to receive more offers from this brand"
															 message:@"\n\n"  
															delegate:self 
												   cancelButtonTitle:@"Cancel"
												   otherButtonTitles:nil , nil];
		
		[remindView addSubview:tv];
		[remindView addButtonWithTitle:@"OK"];
		submitButton = [[remindView subviews] lastObject];
		[submitButton setEnabled:[self validate]];
		
		[remindView show];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{	
	[theTextField resignFirstResponder];
	return YES;
}

-(void) alertView:(UIAlertView*) alertView clickedButtonAtIndex: (NSInteger) buttonIndex
{
	if (([alertView.title isEqual:@"Type your e-mail to receive more offers from this brand"]) && (buttonIndex == 1))
	{
		unsigned char* unfollowBytes = unfollow_png;
		NSUInteger unfollowLength = unfollow_png_len;
		
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[NSData dataWithBytesNoCopy:unfollowBytes length:unfollowLength freeWhenDone:NO]] forState:UIControlStateNormal];		
		
		[_TLRMSTracker saveString:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]:tv.text];
		[(_TL*)tl sendLog:TL_ACTION_FOLLOW:tv.text];
	}
}


-(BOOL) validate 
{	
	BOOL result = [emailTest evaluateWithObject:tv.text];
	
	return result;
}

- (BOOL) textField: (UITextField*) textField shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString*) string
{
	[submitButton setEnabled:[self validate]];
	return true;
}

@end
