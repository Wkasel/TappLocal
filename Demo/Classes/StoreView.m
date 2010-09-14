//
//  StoreView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 18/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "StoreView.h"
#import "TappLocalViewController.h"


@implementation StoreView

-(void) configure:(UIViewController*) parent
{
	controller = parent;
	
	controller = parent;
	
	if (!isBuilt)
	{
		isBuilt = true;
	
		mother = [[TappLocalView alloc]init];
		mother.frame = CGRectMake(0, 0, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		bg = [[UIImageView alloc] initWithFrame: CGRectMake(0, -20, 320, 480)];
		bg.image = [[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"bg.png"]];
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
		label.textColor = [ColorUtils colorFromRGB:@"FFFFFF"];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.text = @"Back";
		label.font = [UIFont fontWithName:@"Arial-BoldMT" size:13.0f];
		[button addSubview:label];
		[button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
		button.frame = CGRectMake(5, 7, 50, 30);
		[mother addSubview:button];
		
		merchantlogo = [[UIButton alloc] initWithFrame: CGRectMake(21, 56, 71, 71)];
		[merchantlogo addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		[mother addSubview:merchantlogo];
		
		merchantname = [[FontLabel alloc] initWithFrame:CGRectMake(100, 72, 200, 20) fontName:@"HelveticaNeueBold" pointSize:18.0f];
		merchantname.textColor = [ColorUtils colorFromRGB:@"000000"];
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
		[mother addSubview:table];
	}
	
	if (store.logo != nil)
		[merchantlogo setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:store.logo]] forState:UIControlStateNormal];
	
	merchantname.text = store.title;
	
	if ([RMSTracker load:store.followname] != nil)
	{
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"following2.png"]] forState:UIControlStateNormal];		
	}
	else
	{
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"follow2.png"]] forState:UIControlStateNormal];
	}
	
		
	[controller.view addSubview:mother];
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
		return 3;
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	
	if ([indexPath indexAtPosition:0]  == 0)
	{
		//phone
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"] autorelease];
				
		FontLabel* phone = [[FontLabel alloc] initWithFrame:CGRectMake(49, 15, 100, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		phone.textColor = [ColorUtils colorFromRGB:@"385487"];
		phone.backgroundColor = nil;
		phone.opaque = NO;
		phone.textAlignment = UITextAlignmentLeft;
		phone.text = @"phone";
		[cell addSubview:phone];
		
		FontLabel* number= [[FontLabel alloc] initWithFrame:CGRectMake(100, 15, 180, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
		number.textColor = [ColorUtils colorFromRGB:@"000000"];
		number.backgroundColor = nil;
		number.opaque = NO;
		number.textAlignment = UITextAlignmentLeft;
		number.text = store.phone;
		[cell addSubview:number];
		
	}
	else if ([indexPath indexAtPosition:0]  == 1)
	{
		//site
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
				
		FontLabel* homepage = [[FontLabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		homepage.textColor = [ColorUtils colorFromRGB:@"385487"];
		homepage.backgroundColor = nil;
		homepage.opaque = NO;
		homepage.textAlignment = UITextAlignmentLeft;
		homepage.text = @"home page";
		[cell addSubview:homepage];
		
		FontLabel* url = [[FontLabel alloc] initWithFrame:CGRectMake(100, 15, 180, 20) fontName:@"HelveticaNeueBold" pointSize:13.0f];
		url.textColor = [ColorUtils colorFromRGB:@"000000"];
		url.backgroundColor = nil;
		url.opaque = NO;
		url.textAlignment = UITextAlignmentLeft;
		url.text = store.url;
		[cell addSubview:url];
		
	}
	else if ([indexPath indexAtPosition:0]  == 2)
	{
		//address
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
				
		cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 50);
		
		FontLabel* address = [[FontLabel alloc] initWithFrame:CGRectMake(40, 15, 100, 20) fontName:@"HelveticaNeue" pointSize:14.0f];
		address.textColor = [ColorUtils colorFromRGB:@"385487"];
		address.backgroundColor = nil;
		address.opaque = NO;
		address.textAlignment = UITextAlignmentLeft;
		address.text = @"address";
		[cell addSubview:address];
		
		FontLabel* street = [[FontLabel alloc] initWithFrame:CGRectMake(100, 15, 180, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
		street.textColor = [ColorUtils colorFromRGB:@"000000"];
		street.backgroundColor = nil;
		street.opaque = NO;
		street.textAlignment = UITextAlignmentLeft;
		street.text = store.address;
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
			directions.textColor = [ColorUtils colorFromRGB:@"385487"];
			directions.backgroundColor = nil;
			directions.opaque = NO;
			directions.textAlignment = UITextAlignmentCenter;
			directions.text = @"Directions To Here";
			[cell addSubview:directions];
		}
		else if ([indexPath indexAtPosition:1]  == 1)
		{
			//invite
			cell = [tableView dequeueReusableCellWithIdentifier:@"3.1"];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
			}
			
			FontLabel* invite = [[FontLabel alloc] initWithFrame:CGRectMake(0, 15, 300, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
			invite.textColor = [ColorUtils colorFromRGB:@"385487"];
			invite.backgroundColor = nil;
			invite.opaque = NO;
			invite.textAlignment = UITextAlignmentCenter;
			invite.text = @"Invite a Friend";
			[cell addSubview:invite];
		}
		else if ([indexPath indexAtPosition:1]  == 2)
		{
			//facebook
			cell = [tableView dequeueReusableCellWithIdentifier:@"3.2"];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"] autorelease];
			}
			
			FontLabel* share = [[FontLabel alloc] initWithFrame:CGRectMake(0, 15, 300, 20) fontName:@"HelveticaNeueBold" pointSize:14.0f];
			share.textColor = [ColorUtils colorFromRGB:@"385487"];
			share.backgroundColor = nil;
			share.opaque = NO;
			share.textAlignment = UITextAlignmentCenter;
			share.text = @"Share On Facebook";
			[cell addSubview:share];
		}
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath indexAtPosition:0]  == 0)
	{
		//phone
		NSMutableString *phone = [[store.phone mutableCopy] autorelease];
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
		[[UIApplication sharedApplication] openURL:url];
	}
	else if ([indexPath indexAtPosition:0]  == 1)
	{
		//site
		NSString *stringURL = store.url;
		NSURL *url = [NSURL URLWithString:stringURL];
		[[UIApplication sharedApplication] openURL:url];
	}
	else if ([indexPath indexAtPosition:0]  == 2)
	{
		//address
		[(TappLocalViewController*)controller setScreen:store.mapname:false];
	}
	else if ([indexPath indexAtPosition:0]  == 3)
	{
		if ([indexPath indexAtPosition:1]  == 0)
		{
			//directions
			[(TappLocalViewController*)controller setScreen:store.mapname:false];

		}
		else if ([indexPath indexAtPosition:1]  == 1)
		{
			//invite
			ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
			picker.peoplePickerDelegate = self;
			[controller presentModalViewController:picker animated:YES];
			[picker release];
		}
		else if ([indexPath indexAtPosition:1]  == 2)
		{
			//facebook
			[self facebookClick];
		}
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
	if ([RMSTracker load:store.followname] != nil)
	{
		[RMSTracker deleteRecordstore:store.followname];
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"follow2.png"]] forState:UIControlStateNormal];		
	}
	else
	{
		[RMSTracker saveString:store.followname :@"yes"];
		[follow setBackgroundImage:[[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"following2.png"]] forState:UIControlStateNormal];
	}
}

-(void) facebookClick
{
	Facebook* facebook = [[Facebook alloc]init];
	NSArray *permissions = [NSArray arrayWithObjects:@"publish_stream", @"email", @"offline_access",  @"user_birthday",@"user_events", @"user_groups",  @"user_likes", @"user_location", @"user_online_presence", @"read_stream",  nil];
	[facebook authorize:@"bbbe5983d6af9dfdd721b34b1f41a020" permissions:permissions delegate:self];
	[facebook logout:nil];
}

-(void) backClick
{
	[mother removeFromSuperview];
}

-(void) closeClick
{
	[(TappLocalViewController*)controller closeCoupons];
}

-(void) removeFromSuperview
{
	[mother removeFromSuperview];
}


-(void) setStore:(Store*) s
{
	store = s;
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
