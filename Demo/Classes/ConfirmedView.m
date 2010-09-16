//
//  ConfirmedView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "ConfirmedView.h"
#import "TappLocalViewController.h"


@implementation ConfirmedView

-(void) configure:(UIViewController*) parent
{
	controller = parent;
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[TappLocalView alloc]init];
		mother.frame = CGRectMake(20, 20, 281, 418);
		mother.backgroundColor = [ColorUtils colorFromRGB:@"CFE8F3"];
	
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 281, 418)];
		bg.image = [[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"confirmed.png"]];
		[mother addSubview:bg];
		
		seemore = [[UIButton alloc] initWithFrame: CGRectMake(30, 140, 215, 46)];
		[seemore setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"seemore.png"]] forState:UIControlStateNormal];
		[seemore addTarget:self action:@selector(seemoreClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:seemore];
		
		moreoffers = [[UIButton alloc] initWithFrame: CGRectMake(30, 190, 219, 46)];
		[moreoffers setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"moreoffers.png"]] forState:UIControlStateNormal];
		[moreoffers addTarget:self action:@selector(moreoffersClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:moreoffers];
		
		sharefriends = [[UIButton alloc] initWithFrame: CGRectMake(30, 240, 215, 46)];
		[sharefriends setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"share.png"]] forState:UIControlStateNormal];
		[sharefriends addTarget:self action:@selector(sharefriendsClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:sharefriends];
		
		follow = [[UIButton alloc] initWithFrame: CGRectMake(30, 290, 215, 46)];
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"followmerchant.png"]] forState:UIControlStateNormal];
		[follow addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:follow];
		
		close = [[UIButton alloc] initWithFrame: CGRectMake(220, 0, 60, 40)];
		[close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:close];
	}
	
	bg.hidden = true;	
	seemore.hidden = true;
	moreoffers.hidden = true;
	sharefriends.hidden = true;
	follow.hidden = true;	
	
	mother.frame = CGRectMake(160, 230, 0, 0);
	
	[UIView beginAnimations:nil context:NULL]; 
	{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidFinishOpen:finished:context:) ];
		
		mother.frame = CGRectMake(20, 20, 281, 418);	
		
	} [UIView commitAnimations];
	
	
	[controller.view addSubview:mother];
}

- (void) animationDidFinishOpen:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	bg.hidden = false;	
	seemore.hidden = false;
	moreoffers.hidden = false;
	sharefriends.hidden = false;
	follow.hidden = false;	
}

-(void) seemoreClick
{
	[(TappLocalViewController*)controller setScreen:@"SCREEN_MAP":false];
}

-(void) moreoffersClick
{
	[(TappLocalViewController*)controller setScreen:@"SCREEN_MAP":false];	
}

-(void) sharefriendsClick
{
	//invite
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;
	[controller presentModalViewController:picker animated:YES];
	[picker release];
}


-(void) followClick
{
	Facebook* facebook = [[Facebook alloc]init];
	NSArray *permissions = [NSArray arrayWithObjects: @"email", nil];
	[facebook authorize:@"bbbe5983d6af9dfdd721b34b1f41a020" permissions:permissions delegate:self];
	[facebook logout:nil];
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
		
		[controller dismissModalViewControllerAnimated:YES];
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
	[controller dismissModalViewControllerAnimated:true];
}

@end
