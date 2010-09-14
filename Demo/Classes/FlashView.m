//
//  FlashView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 20/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "FlashView.h"
#import "TappLocalViewController.h"

@implementation FlashView

-(void) configure:(UIViewController*) parent
{
	controller = parent;
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[TappLocalView alloc]init];
		mother.frame = CGRectMake(0, 480, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, -20, 320, 480)];
		bg.image = [[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"bg_flash.png"]];
		[mother addSubview:bg];
		
		top = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		top.barStyle = UIBarStyleBlackTranslucent;
		[mother addSubview:top];	
		
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
		UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Nearby Special"];
		item.rightBarButtonItem = rightButton;
		item.hidesBackButton = YES;
		[top pushNavigationItem:item animated:NO];
		
		merchantlogo = [[UIButton alloc] initWithFrame: CGRectMake(54, 108, 214, 50)];
		[merchantlogo addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogo];
			
		directions = [[UIButton alloc] initWithFrame: CGRectMake(50, 355, 74, 31)];
		[directions setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"directions.png"]] forState:UIControlStateNormal];
		[directions addTarget:self action:@selector(directionsClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:directions];
		
		bring = [[UIButton alloc] initWithFrame: CGRectMake(124, 355, 74, 30)];
		[bring setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"bring.png"]] forState:UIControlStateNormal];
		[bring addTarget:self action:@selector(bringClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:bring];
		
		moredetails = [[UIButton alloc] initWithFrame: CGRectMake(198, 355, 74, 31)];
		[moredetails setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"more_details.png"]] forState:UIControlStateNormal];
		[moredetails addTarget:self action:@selector(moreDealsClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:moredetails];
		
		remindme = [[UIButton alloc] initWithFrame: CGRectMake(50, 398, 220, 37)];
		[remindme setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"remind_me.png"]] forState:UIControlStateNormal];
		[remindme addTarget:self action:@selector(remindmeClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:remindme];
		
		

	}
	
	mother.frame = CGRectMake(0, 480, 320, 480);
		
	[UIView beginAnimations:nil context:NULL]; 
	{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
			
		mother.frame = CGRectMake(0, 0, 320, 480);
			
	} [UIView commitAnimations];
	
	[controller.view addSubview:mother];
}


-(void) merchantClick
{
	[(TappLocalViewController*)controller setScreen:@"SCREEN_STORE_TRES":false];
}

-(void) remindmeClick
{
	UIAlertView* remindView = [[UIAlertView alloc] initWithTitle:@"Reminder"
														message:@"We will remind you in one hour!"  
													   delegate:self 
											  cancelButtonTitle:@"Ok"
											  otherButtonTitles:nil , nil];
	
	[remindView show];
}

-(void) directionsClick
{
	[(TappLocalViewController*)controller setScreen:@"SCREEN_SINGLEMAP_TRES":false];
}

-(void) bringClick
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;
	[controller presentModalViewController:picker animated:YES];
	[picker release];
}

-(void) moreDealsClick
{
	[(TappLocalViewController*)controller setScreen:@"SCREEN_MAP_TRES":false];
}

- (void) animationDidStopClose:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[(TappLocalViewController*)controller closeCoupons];
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

-(void) removeFromSuperview
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
