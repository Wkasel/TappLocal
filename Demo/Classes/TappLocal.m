//
//  TappLocal.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 04/10/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "TappLocal.h"
#import <AudioToolbox/AudioServices.h> 

@implementation TappLocal

@synthesize vc;

static TappLocal *gInstance = nil;

+(TappLocal*) instanceWithController:(UIViewController*) v
{
	@synchronized(self)
	{
		if (gInstance == nil)
		{
			gInstance = [[self alloc] init:v];
		}
	}
	return(gInstance);
}

+(TappLocal*) instance
{
	@synchronized(self)
	{
		if (gInstance == nil)
		{
			NSLog(@"ERROR! Call instanceWithController first!");
		}
	}
	return(gInstance);
}
	
-(TappLocal*) init:(UIViewController*)v
{
	[super init];
	
	[self turnGpsOn];
	
	[[FontManager sharedManager] loadFont:@"Digital"];
	
	dView = [[_TLDealView alloc] init];
	mView = [[_TLMapView alloc] init];
	sView = [[_TLStoreView alloc] init];
	smView = [[_TLSingleMapView alloc] init];
	cView = [[_TLConfirmedView alloc] init];
	vc = v;
	
	nearby = [[UIButton alloc] initWithFrame: CGRectMake(320, 115, 65, 39)];
	[nearby setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"nearby.png"]] forState:UIControlStateNormal];
	[nearby addTarget:self action:@selector(couponClick) forControlEvents:UIControlEventTouchUpInside];
	
	flash = [[UIButton alloc] initWithFrame: CGRectMake(0, 460, 320, 35)];
	[flash setBackgroundImage:[[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"flash.png"]] forState:UIControlStateNormal];
	flash.hidden = true;
	flash.alpha = 0.6;
	[flash addTarget:self action:@selector(flashClick) forControlEvents:UIControlEventTouchUpInside];
	
	flashText = [[FontLabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30) fontName:@"HelveticaNeue" pointSize:12.0f];
	flashText.textColor = [_TLColorUtils colorFromRGB:@"000000"];
	flashText.backgroundColor = nil;
	flashText.opaque = NO;
	flashText.numberOfLines = 2;
	flashText.textAlignment = UITextAlignmentCenter;
	flashText.text = @"support@tapplocal.com";
	
	return self;
}


-(void)setScreen:(NSString*) newScreen:(bool)isBack
{
	if ([newScreen isEqualToString: @"SCREEN_DEAL"])
	{
		//deal screen
		[dView configure:self];
	}
	else if ([newScreen isEqualToString: @"SCREEN_STORE"])
	{
		[sView configure:self];	
	}
	else if ([newScreen isEqualToString: @"SCREEN_MAP"])
	{
		[mView configure:self];	
	}
	else if ([newScreen isEqualToString: @"SCREEN_SINGLEMAP"])
	{
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
	for (int i=[[vc.view subviews] count]-1;i>=0;i--)
	{
		UIView* current = [[vc.view subviews] objectAtIndex:i];
		
		if ([current isKindOfClass:[_TLTappLocalView class]])
		{
			[current performSelector:@selector(removeFromSuperview)];
		}
		
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	lastLatitude = newLocation.coordinate.latitude;
	lastLongitude = newLocation.coordinate.longitude;
	
	NSString* server = @"http://72.47.200.205/xml/";
	
	NSString* file = [NSString stringWithFormat:@"%.3fi%.3f",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
	file = [NSString stringWithFormat:@"%@%@.xml", server, [file stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
	
	NSURL* url = [NSURL URLWithString:file];
	NSString* xml = [NSString stringWithContentsOfURL:url];
	
	if (xml != nil)
	{
		NSMutableArray* coupons = [_TLCouponsXmlParser xmlToCoupons:xml];
		
		int index = rand() % [coupons count]; 
		
		currentCoupon = [coupons objectAtIndex:index];
	}
}

-(_TLCoupon*)getCurrentCoupon
{
	return currentCoupon;
}

-(void)turnGpsOn
{
	//turn on GPS
	CLLocationManager* locationManager=[[CLLocationManager alloc]init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
}

-(void)showNearby
{
	if (currentCoupon != nil)
	{
		[nearby removeFromSuperview];
		[vc.view addSubview:nearby];
		
		[flash removeFromSuperview];
		[vc.view addSubview:flash];
		
		[flashText removeFromSuperview];
		[flash addSubview:flashText];
		
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
}

-(void)showFlash
{
	if (currentCoupon != nil)
	{
		flashText.text = [NSString stringWithFormat:@"%@ - %@", currentCoupon.title, currentCoupon.text];
		
		movingFlashIn = !movingFlashIn;
		
		[nearby removeFromSuperview];
		[vc.view addSubview:nearby];
		
		[flash removeFromSuperview];
		[vc.view addSubview:flash];
		
		[flashText removeFromSuperview];
		[flash addSubview:flashText];
		
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
	
	[self setScreen:@"SCREEN_DEAL":false];
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
	
	[self setScreen:@"SCREEN_DEAL":false];
}

-(void) dealloc
{
	[lastXml release];
	[nearby release];
	[flash release];
	[flashText release];
	[currentCoupon release];
	
	[dView release];
	[mView release];
	[sView release];	
	[smView release];
	[cView release];		
	
	[super dealloc];
}

@end
