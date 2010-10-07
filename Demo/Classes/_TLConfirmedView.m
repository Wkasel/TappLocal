//
//  ConfirmedView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLConfirmedView.h"
#import "TappLocalViewController.h"
#import "TappLocal.h"

@implementation _TLConfirmedView

-(void) configure:(id) parent
{
	tl = parent;
	
	coupon = [(TappLocal*)tl getCurrentCoupon];
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[_TLTappLocalView alloc]init];
		mother.frame = CGRectMake(20, 20, 281, 418);
		mother.backgroundColor = [_TLColorUtils colorFromRGB:@"CFE8F3"];
	
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 281, 418)];
		bg.image = [[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"confirmed.png"]];
		[mother addSubview:bg];
		
		show = [[FontLabel alloc] initWithFrame:CGRectMake(10, 90, 260, 20) fontName:@"HelveticaNeue" pointSize:16.0f];
		show.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		show.backgroundColor = nil;
		show.opaque = NO;
		show.textAlignment = UITextAlignmentCenter;
		show.text = @"Please present this to the merchant!";		
		[mother addSubview:show];
		
		merchantlogo = [[UIButton alloc] initWithFrame: CGRectMake(100, 120, 80, 80)];
		[merchantlogo addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogo];		
		
		title = [[FontLabel alloc] initWithFrame:CGRectMake(10, 210, 260, 20) fontName:@"HelveticaNeue" pointSize:18.0f];
		title.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		title.backgroundColor = nil;
		title.opaque = NO;
		title.textAlignment = UITextAlignmentCenter;
		[mother addSubview:title];
		
		text1 = [[FontLabel alloc] initWithFrame:CGRectMake(10, 226, 260, 70) fontName:@"HelveticaNeue" pointSize:16.0f];
		text1.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text1.backgroundColor = nil;
		text1.opaque = NO;
		text1.textAlignment = UITextAlignmentCenter;
		text1.numberOfLines = 3;
		[mother addSubview:text1];
		
		text2 = [[FontLabel alloc] initWithFrame:CGRectMake(10, 300, 260, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		text2.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text2.backgroundColor = nil;
		text2.opaque = NO;
		text2.textAlignment = UITextAlignmentCenter;

		[mother addSubview:text2];
		
		text3 = [[FontLabel alloc] initWithFrame:CGRectMake(10, 322, 260, 20) fontName:@"HelveticaNeue" pointSize:10.0f];
		text3.textColor = [_TLColorUtils colorFromRGB:@"747474"];
		text3.backgroundColor = nil;
		text3.opaque = NO;
		text3.textAlignment = UITextAlignmentCenter;
		[mother addSubview:text3];
		
		sendMe = [[UIButton alloc] initWithFrame: CGRectMake(30, 360, 220, 37)];
		[sendMe setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"send_me.png"]] forState:UIControlStateNormal];
		[sendMe addTarget:self action:@selector(sendMeClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:sendMe];		
		
		close = [[UIButton alloc] initWithFrame: CGRectMake(220, 0, 60, 40)];
		[close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:close];
		
		tv = [[UITextField alloc] initWithFrame:CGRectMake(12,65,260,22)];
		tv.autocapitalizationType = UITextAutocapitalizationTypeNone;
		tv.autocorrectionType = UITextAutocorrectionTypeNo;
		tv.backgroundColor = [UIColor whiteColor];
		tv.returnKeyType = UIReturnKeyDone;
		tv.delegate = self;
		tv.textAlignment = UITextAlignmentCenter;
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
	sendMe.hidden = true;
	
	mother.frame = CGRectMake(160, 230, 0, 0);
	
	[UIView beginAnimations:nil context:NULL]; 
	{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidFinishOpen:finished:context:) ];
		
		mother.frame = CGRectMake(20, 20, 281, 418);	
		
	} [UIView commitAnimations];
	
	
	[((TappLocal*)tl).vc.view addSubview:mother];
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
	sendMe.hidden = false;
}

-(void) seemoreClick
{
	[tl setScreen:@"SCREEN_MAP":false];
}

-(void) moreoffersClick
{
	[tl setScreen:@"SCREEN_MAP":false];	
}

-(void) sharefriendsClick
{
	//invite
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;
	[tl presentModalViewController:picker animated:YES];
	[picker release];
}

-(void) closeClick
{
	[mother removeFromSuperview];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	if (property == kABPersonPhoneProperty) 
	{
		ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
		NSString *phone1 = (NSString *)ABMultiValueCopyValueAtIndex(phoneProperty,identifier);
		
		NSMutableString *phone = [[phone1 mutableCopy] autorelease];
		[phone replaceOccurrencesOfString:@" " 
							   withString:@"" 
								  options:NSLiteralSearch 
									range:NSMakeRange(0, [phone length])];
		[phone replaceOccurrencesOfString:@"-" 
							   withString:@"" 
								  options:NSLiteralSearch 
									range:NSMakeRange(0, [phone length])];
		[phone replaceOccurrencesOfString:@"(" 
							   withString:@"" 
								  options:NSLiteralSearch 
									range:NSMakeRange(0, [phone length])];
		[phone replaceOccurrencesOfString:@")" 
							   withString:@"" 
								  options:NSLiteralSearch 
									range:NSMakeRange(0, [phone length])];
		
		NSString* url = [NSString stringWithFormat:@"sms:%@",phone];
		[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
		
		[tl dismissModalViewControllerAnimated:YES];
		return NO;
	}
	else
	{
		UIAlertView* remindView = [[UIAlertView alloc] initWithTitle:@"SMS"
															 message:@"Please select the number to send a sms!"  
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil , nil];
		
		[remindView show];
		
		return NO;
	}
	
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	[tl dismissModalViewControllerAnimated:true];
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
	[sendMe release];
	[tv release];
	
	[super dealloc];
}

-(void)sendMeClick
{
	UIAlertView* remindView = [[UIAlertView alloc] initWithTitle:@"Type your e-mail to receive more offers from this brand"
														 message:@"\n"  
														delegate:self 
											   cancelButtonTitle:@"Ok"
											   otherButtonTitles:nil , nil];
	
	[remindView addSubview:tv];
	
	[remindView show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{	
	[theTextField resignFirstResponder];
	return YES;
}

-(void) alertView:(UIAlertView*) alertView clickedButtonAtIndex: (NSInteger) buttonIndex
{
	if ([alertView.title isEqual:@"Type your e-mail to receive more offers from this brand"])
	{
		NSLog(@"Email: %@",tv.text);
		[sendMe setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"registered.png"]] forState:UIControlStateNormal];
		[sendMe removeTarget:self action:@selector(sendMeClick) forControlEvents:UIControlEventTouchUpInside];
	}
}

@end
