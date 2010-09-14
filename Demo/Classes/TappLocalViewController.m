//
//  GameClockViewController.m
//  GameClock
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import "TappLocalViewController.h"
#import <AudioToolbox/AudioServices.h> 


@implementation TappLocalViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[FontManager sharedManager] loadFont:@"Digital"];
		
	dView = [[DealView alloc] init];
	hView = [[HomeView alloc] init];
	mView = [[MapView alloc] init];
	sView = [[StoreView alloc] init];
	smView = [[SingleMapView alloc] init];
	fView = [[FlashView alloc] init];
	cView = [[ConfirmedView alloc] init];
	
	Test* test = [[Test alloc] init];
	test.number1 = 4;
	test.number2 = 7;
	NSLog(@"%i",[test multiply]);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(void)setScreen:(NSString*) newScreen:(bool)isBack
{

	if ([newScreen isEqualToString: @"SCREEN_HOME"])
	{
		//home screen	
		[hView configure:self];
	}
	else if ([newScreen isEqualToString: @"SCREEN_DEAL"])
	{
		//deal screen
		[dView configure:self];
	}
	else if ([newScreen isEqualToString: @"SCREEN_FLASH"])
	{
		//deal screen
		[fView configure:self];
	}
	else if ([newScreen isEqualToString: @"SCREEN_STORE_JOLLIBEE"])
	{
		//store screen jollibee
		Store* store = [[Store alloc]init];
		store.address = @"200, 4th Street";
		store.followname = @"jollibee_follow";
		store.logo = @"merchant_logo2.png";
		store.mapname = @"SCREEN_SINGLEMAP_JOLLIBEE";
		store.phone = @"+1 415 904-8615";
		store.title = @"Jollibee";
		store.url = @"http://www.jollibeeusa.com";
		[sView setStore:store];	
		[sView configure:self];	
	}
	else if ([newScreen isEqualToString: @"SCREEN_STORE_TRES"])
	{
		//store screen tres agaves
		Store* store = [[Store alloc]init];
		store.address = @"130, Townsend Street";
		store.followname = @"tres_follow";
		store.logo = nil;
		store.mapname = @"SCREEN_SINGLEMAP_TRES";
		store.phone = @"+1 415 227-0500";
		store.title = @"Tres Agaves";
		store.url = @"http://www.tresagaves.com";
		[sView setStore:store];	
		[sView configure:self];			
	}
	else if ([newScreen isEqualToString: @"SCREEN_MAP_JOLLIBEE"])
	{
		//map screen jollibee
		NSMutableArray* temp = [[NSMutableArray alloc] init];
		Coupon* c1 = [[Coupon alloc]init];
		c1.title = @"Jollibee";
		c1.text = @"Half off Fish n' Chips!";
		c1.latitude = 37.78319; 
		c1.longitude = -122.402796; 
		c1.storename = @"SCREEN_STORE_JOLLIBEE";	
		[temp addObject:c1];
		
		Coupon* c2 = [[Coupon alloc]init];
		c2.title = @"Jollibee";
		c2.text = @"Half off Yumm!";
		c2.latitude = 37.58319; 
		c2.longitude = -122.002796; 
		c2.storename = @"SCREEN_STORE_JOLLIBEE";
		[temp addObject:c2];
		
		Coupon* c3 = [[Coupon alloc]init];
		c3.title = @"Jollibee";
		c2.text = @"Half off Yumm!";
		c3.latitude = 37.38319; 
		c3.longitude = -122.142796; 
		c3.storename = @"SCREEN_STORE_JOLLIBEE";
		[temp addObject:c3];
		
		[mView setCoupons:temp];
		
		[mView configure:self];	
	}
	else if ([newScreen isEqualToString: @"SCREEN_MAP_TRES"])
	{
		//map screen tres agaves
		
		//map screen
		NSMutableArray* temp = [[NSMutableArray alloc] init];
		Coupon* c1 = [[Coupon alloc]init];
		c1.title = @"Tres Agaves";
		c1.text = @"50% off Margaritas!";
		c1.latitude = 37.780584; 
		c1.longitude = -122.391556; 
		c1.storename = @"SCREEN_STORE_TRES";
		[temp addObject:c1];
		
		Coupon* c2 = [[Coupon alloc]init];
		c2.title = @"Tres Agaves";
		c2.text = @"Margaritas half off!";
		c2.latitude = 38.767887; 
		c2.longitude = -121.269751; 
		c2.storename = @"SCREEN_STORE_TRES";
		[temp addObject:c2];
		
		[mView setCoupons:temp];
		
		[mView configure:self];	
	}
	else if ([newScreen isEqualToString: @"SCREEN_SINGLEMAP_JOLLIBEE"])
	{
		//singlemap screen
		Coupon* c1 = [[Coupon alloc]init];
		c1.title = @"Jollibee";
		c1.text = @"Half off Fish n' Chips!";
		c1.latitude = 37.78319; 
		c1.longitude = -122.402796; 
		c1.storename = @"SCREEN_STORE_JOLLIBEE";
		[smView setCoupon:c1];
		[smView configure:self];	
	}
	else if ([newScreen isEqualToString: @"SCREEN_SINGLEMAP_TRES"])
	{
		//singlemap screen
		Coupon* c1 = [[Coupon alloc]init];
		c1.title = @"Tres Agaves";
		c1.text = @"50% off Margaritas!";
		c1.latitude = 37.780584; 
		c1.longitude = -122.391556; 
		c1.storename = @"SCREEN_STORE_TRES";
		[smView setCoupon:c1];
		[smView configure:self];	
	}
	else if ([newScreen isEqualToString: @"SCREEN_CONFIRMED"])
	{
		//confirmed screen
		[cView configure:self];	
	}
}


-(void) alertView:(UIAlertView*) alertView clickedButtonAtIndex: (NSInteger) buttonIndex
{
	exit(0);
}

-(void)closeCoupons
{
	//remove every view belonging tapplocal
	for (int i=[[self.view subviews] count]-1;i>=0;i--)
	{
		UIView* current = [[self.view subviews] objectAtIndex:i];
		
		if ([current isKindOfClass:[TappLocalView class]])
		{
			[current performSelector:@selector(removeFromSuperview)];
		}
		
	}
}


@end
