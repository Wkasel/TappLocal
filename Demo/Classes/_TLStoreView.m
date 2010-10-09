//
//  StoreView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 18/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLStoreView.h"
#import "TappLocalViewController.h"
#import "_TL.h"

@implementation _TLStoreView

-(void) configure:(id) parent
{
	tl = parent;
	
	coupon = [(_TL*)tl getCurrentCoupon];
	
	if (!isBuilt)
	{
		isBuilt = true;
	
		mother = [[_TLTappLocalView alloc]init];
		mother.frame = CGRectMake(0, 0, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, -20, 320, 480)];
		bg.image = [[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"bg.png"]];
		[mother addSubview:bg];
		
		top = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		top.barStyle = UIBarStyleBlackTranslucent;
		[mother addSubview:top];	

		UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
		UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"Business Info"];
		item.rightBarButtonItem = rightButton;
		[top pushNavigationItem:item animated:NO];
		
		UIButton* button = [UIButton buttonWithType:101];
		UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 35, 20)];
		label.textColor = [_TLColorUtils colorFromRGB:@"FFFFFF"];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.text = @"Back";
		label.font = [UIFont fontWithName:@"Arial-BoldMT" size:13.0f];
		[button addSubview:label];
		[button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
		button.frame = CGRectMake(5, 7, 50, 30);
		[mother addSubview:button];
		
		merchantlogo = [[UIButton alloc] initWithFrame: CGRectMake(21, 56, 71, 71)];
		[mother addSubview:merchantlogo];
		
		merchantname = [[FontLabel alloc] initWithFrame:CGRectMake(100, 72, 200, 20) fontName:@"HelveticaNeueBold" pointSize:18.0f];
		merchantname.textColor = [_TLColorUtils colorFromRGB:@"000000"];
		merchantname.backgroundColor = nil;
		merchantname.opaque = NO;
		merchantname.textAlignment = UITextAlignmentLeft;
		[mother addSubview:merchantname];
		
		follow = [[UIButton alloc] initWithFrame: CGRectMake(100, 95, 119, 24)];
			
		[follow addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:follow];
		
		table = [[UITableView alloc] initWithFrame:CGRectMake(10, 130, 300, 320) style:UITableViewStyleGrouped];
		table.delegate = self;
		table.dataSource = self;
		table.backgroundColor = [UIColor clearColor];
		table.scrollEnabled = false;
		[mother addSubview:table];
		
		tv = [[UITextField alloc] initWithFrame:CGRectMake(12,65,260,22)];
		tv.autocapitalizationType = UITextAutocapitalizationTypeNone;
		tv.autocorrectionType = UITextAutocorrectionTypeNo;
		tv.backgroundColor = [UIColor whiteColor];
		tv.returnKeyType = UIReturnKeyDone;
		tv.delegate = self;
		tv.textAlignment = UITextAlignmentCenter;
	}
	
	if ([coupon getMerchant].logo != nil)
		[merchantlogo setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:[coupon getMerchant].logo]] forState:UIControlStateNormal];
	
	merchantname.text = [coupon getMerchant].name;
	
	if ([_TLRMSTracker load:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]] != nil)
	{
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"following2.png"]] forState:UIControlStateNormal];	
		tv.text = [_TLRMSTracker loadSafeString:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]];
	}
	else
	{
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"follow2.png"]] forState:UIControlStateNormal];
	}
	
	[((_TL*)tl).vc.view addSubview:mother];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0)
		return 1;
	else if (section == 1)
		return 1;
	else if (section == 2)
		return 1;
	else if (section == 3)
		return 1;
	
	return 0;
}

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section != 1)
		return 40;
	else
		return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	
	if ([indexPath indexAtPosition:0]  == 0)
	{
		//phone
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"] autorelease];
				
		FontLabel* phone = [[FontLabel alloc] initWithFrame:CGRectMake(49, 15, 100, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		phone.textColor = [_TLColorUtils colorFromRGB:@"385487"];
		phone.backgroundColor = nil;
		phone.opaque = NO;
		phone.textAlignment = UITextAlignmentLeft;
		phone.text = @"phone";
		[cell addSubview:phone];
		
		FontLabel* number= [[FontLabel alloc] initWithFrame:CGRectMake(100, 15, 180, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
		number.textColor = [_TLColorUtils colorFromRGB:@"000000"];
		number.backgroundColor = nil;
		number.opaque = NO;
		number.textAlignment = UITextAlignmentLeft;
		number.text = [coupon getMerchant].phone;
		[cell addSubview:number];
		
	}
	else if ([indexPath indexAtPosition:0]  == 1)
	{
		//site
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
		
		FontLabel* homepage = [[FontLabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		homepage.textColor = [_TLColorUtils colorFromRGB:@"385487"];
		homepage.backgroundColor = nil;
		homepage.opaque = NO;
		homepage.textAlignment = UITextAlignmentLeft;
		homepage.text = @"description";
		[cell addSubview:homepage];
		
		FontLabel* desc = [[FontLabel alloc] initWithFrame:CGRectMake(100, 15, 180, 150) fontName:@"HelveticaNeueBold" pointSize:13.0f];
		desc.textColor = [_TLColorUtils colorFromRGB:@"000000"];
		desc.backgroundColor = nil;
		desc.opaque = NO;
		desc.numberOfLines = 0;
		desc.textAlignment = UITextAlignmentLeft;
		desc.text = [coupon getMerchant].description;
		[cell addSubview:desc];
		
		cell.autoresizesSubviews = TRUE;
		
	}
	else if ([indexPath indexAtPosition:0]  == 2)
	{
		//address
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
				
		cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 50);
		
		FontLabel* address = [[FontLabel alloc] initWithFrame:CGRectMake(40, 15, 100, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		address.textColor = [_TLColorUtils colorFromRGB:@"385487"];
		address.backgroundColor = nil;
		address.opaque = NO;
		address.textAlignment = UITextAlignmentLeft;
		address.text = @"address";
		[cell addSubview:address];
		
		FontLabel* street = [[FontLabel alloc] initWithFrame:CGRectMake(100, 15, 180, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
		street.textColor = [_TLColorUtils colorFromRGB:@"000000"];
		street.backgroundColor = nil;
		street.opaque = NO;
		street.textAlignment = UITextAlignmentLeft;
		street.text = ((_TLStore*)[[coupon getStores] objectAtIndex:0]).address;
		[cell addSubview:street];
	}
	else if ([indexPath indexAtPosition:0]  == 3)
	{
		if ([indexPath indexAtPosition:1]  == 0)
		{
			//directions
			cell = [tableView dequeueReusableCellWithIdentifier:@"3.0"];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
			}
			
			FontLabel* directions = [[FontLabel alloc] initWithFrame:CGRectMake(0, 15, 300, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
			directions.textColor = [_TLColorUtils colorFromRGB:@"385487"];
			directions.backgroundColor = nil;
			directions.opaque = NO;
			directions.textAlignment = UITextAlignmentCenter;
			directions.text = @"Directions To Here";
			[cell addSubview:directions];
		}
	/*	else if ([indexPath indexAtPosition:1]  == 1)
		{
			//invite
			cell = [tableView dequeueReusableCellWithIdentifier:@"3.1"];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
			}
			
			FontLabel* invite = [[FontLabel alloc] initWithFrame:CGRectMake(0, 15, 300, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
			invite.textColor = [_TLColorUtils colorFromRGB:@"385487"];
			invite.backgroundColor = nil;
			invite.opaque = NO;
			invite.textAlignment = UITextAlignmentCenter;
			invite.text = @"Invite a Friend";
			[cell addSubview:invite];
		}*/
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath indexAtPosition:0]  == 0)
	{
/*		//phone
		NSMutableString *phone = [[[coupon getMerchant].phone mutableCopy] autorelease];
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
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]];
		[[UIApplication sharedApplication] openURL:url];*/
	}
	else if ([indexPath indexAtPosition:0]  == 1)
	{
/*		//site
		NSString *stringURL = [coupon getMerchant].site;
		NSURL *url = [NSURL URLWithString:stringURL];
		[[UIApplication sharedApplication] openURL:url];*/
	}
	else if ([indexPath indexAtPosition:0]  == 2)
	{
		//address
		[(_TL*)tl setScreen:@"SCREEN_SINGLEMAP":false];
	}
	else if ([indexPath indexAtPosition:0]  == 3)
	{
		if ([indexPath indexAtPosition:1]  == 0)
		{
			//directions
			[(_TL*)tl setScreen:@"SCREEN_SINGLEMAP":false];

		}
	/*	else if ([indexPath indexAtPosition:1]  == 1)
		{
			//invite
			ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
			picker.peoplePickerDelegate = self;
			[((_TL*)tl).vc presentModalViewController:picker animated:YES];
			[picker release];
		}*/
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 4;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 6;
    return 1.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

-(void) followClick
{
	if ([_TLRMSTracker load:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]] != nil)
	{
		[_TLRMSTracker deleteRecordstore:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]];
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"follow2.png"]] forState:UIControlStateNormal];
		[(_TL*)tl sendLog:TL_ACTION_UNFOLLOW:nil];
	}
	else
	{
		UIAlertView* remindView = [[UIAlertView alloc] initWithTitle:@"Type your e-mail to receive more offers from this brand"
															 message:@"\n"  
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil , nil];
		
		[remindView addSubview:tv];
		
		[remindView show];
	}
}

-(void) backClick
{
	[mother removeFromSuperview];
}

-(void) closeClick
{
	[(_TL*)tl sendLog:TL_ACTION_CLOSE:nil];
	[(_TL*)tl closeCoupons];
}

-(void) removeFromSuperview
{
	[mother removeFromSuperview];
}

/*- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
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
		
		[((_TL*)tl).vc dismissModalViewControllerAnimated:YES];
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
	[((_TL*)tl).vc dismissModalViewControllerAnimated:true];
}*/

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{	
	[theTextField resignFirstResponder];
	return YES;
}

-(void) alertView:(UIAlertView*) alertView clickedButtonAtIndex: (NSInteger) buttonIndex
{
	if ([alertView.title isEqual:@"Type your e-mail to receive more offers from this brand"])
	{
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"following2.png"]] forState:UIControlStateNormal];
		[_TLRMSTracker saveString:[NSString stringWithFormat:@"%i",[coupon getMerchant].idmerchant]:tv.text];
		[(_TL*)tl sendLog:TL_ACTION_FOLLOW:tv.text];
	}
}

-(void) dealloc
{
	[mother release];
	[bg release];
	[top release];
	[close release];
	[merchantlogo release];
	[follow release];
	[merchantname release];
	[table release];	
	
	[super dealloc];
}


@end
