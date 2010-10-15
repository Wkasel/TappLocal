//
//  TappLocal.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 04/10/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TL.h"
#import "nearby.png.h"

@implementation _TL

@synthesize vc;
@synthesize lastLatitude;
@synthesize lastLongitude;
@synthesize refreshTime;

int const TL_ACTION_FLAG = 0;
int const TL_ACTION_VIEW = 1;
int const TL_ACTION_DIRECTIONS = 2;
int const TL_ACTION_NO_THANKS = 3;
int const TL_ACTION_CLOSE = 4;
int const TL_ACTION_MORE_DEALS = 5;
int const TL_ACTION_USED_FAR = 6;
int const TL_ACTION_USED_OK = 7;
int const TL_ACTION_MERCHANT = 8;
int const TL_ACTION_FOLLOW = 9;
int const TL_ACTION_UNFOLLOW = 10;

-(void)turnGpsOn
{
	//turn on GPS
	locationManager= [[CLLocationManager alloc]init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
}

-(void)start
{	
	[self turnGpsOn];
	clock = [[NSTimer scheduledTimerWithTimeInterval:refreshTime target:self selector:@selector(timer) userInfo:nil repeats:YES] retain];
}

-(void)stop
{
	[clock invalidate];
	[clock release];
	clock = nil;
}
	
-(_TL*) initWithController:(UIViewController*)v:(NSString*)c
{
	[super init];
	
	dView = [[_TLDealView alloc] init];
	mView = [[_TLMapView alloc] init];
	sView = [[_TLStoreView alloc] init];
	smView = [[_TLSingleMapView alloc] init];
	cView = [[_TLConfirmedView alloc] init];
	vc = v;

	unsigned char *nearbyBytes = nearby_png;
	NSUInteger nearbyLength = nearby_png_len;
	
	nearby = [[UIButton alloc] initWithFrame: CGRectMake(320, 115, 65, 39)];
	[nearby setBackgroundImage:[UIImage imageWithData:[NSData dataWithBytesNoCopy:nearbyBytes length:nearbyLength freeWhenDone:NO]] forState:UIControlStateNormal];	
	[nearby addTarget:self action:@selector(couponClick) forControlEvents:UIControlEventTouchUpInside];
	
	coupons = [[NSMutableArray alloc] init];
	
	refreshTime = 60;
	code = [c retain];
	
	udid = [UIDevice currentDevice].uniqueIdentifier;
	[udid retain];
	
	return self;
}


-(void)setScreen:(NSString*) newScreen:(bool)isBack
{
	if ([newScreen isEqualToString: @"SCREEN_DEAL"])
	{
		//deal screen
		[dView configure:self];
		[self sendLog:TL_ACTION_VIEW:nil];
	}
	else if ([newScreen isEqualToString: @"SCREEN_STORE"])
	{
		[sView configure:self];	
		[self sendLog:TL_ACTION_MERCHANT:nil];
	}
	else if ([newScreen isEqualToString: @"SCREEN_MAP"])
	{
		[mView configure:self];	
		[self sendLog:TL_ACTION_MORE_DEALS:nil];
	}
	else if ([newScreen isEqualToString: @"SCREEN_SINGLEMAP"])
	{
		[smView configure:self];	
		[self sendLog:TL_ACTION_DIRECTIONS:nil];
	}
	else if ([newScreen isEqualToString: @"SCREEN_CONFIRMED"])
	{
		//confirmed screen
		[cView configure:self];	
		[self sendLog:TL_ACTION_USED_OK:nil];
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


-(BOOL)isOpened
{
	//remove every view belonging tapplocal
	for (int i=[[vc.view subviews] count]-1;i>=0;i--)
	{
		UIView* current = [[vc.view subviews] objectAtIndex:i];
		
		if ([current isKindOfClass:[_TLTappLocalView class]])
		{
			return true;
		}
	}
	
	return false;
}

-(void)showNearby
{
	if (currentCoupon != nil)
	{
		[nearby removeFromSuperview];
		[vc.view addSubview:nearby];
		
		movingNearbyIn = !movingNearbyIn;
		
		[UIView beginAnimations:nil context:NULL]; {
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:1.0];
			[UIView setAnimationDelegate:self];
			if (movingNearbyIn) 
			{
				nearby.frame = CGRectMake(255,  115, 65, 39);
				[self sendLog:TL_ACTION_FLAG:nil];
			}
			else 
			{
				nearby.frame = CGRectMake(320,  115, 65, 39);	
			}
			
		} [UIView commitAnimations];
		
		[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(hide) userInfo:nil repeats:NO];
	}
}


-(void)removeDismissed:(NSMutableArray*) arr
{
	for (int i=[arr count]-1;i>=0;i--)
	{
		_TLCoupon* coupon = [arr objectAtIndex:i];
		
		NSString* dismissed = [_TLRMSTracker loadSafeString:[NSString stringWithFormat:@"coupon_%i",coupon.idcoupon]];
		
		if (dismissed != nil)
		{
			[coupon release];
			[arr removeObjectAtIndex:i];
		}
		
	}
	
}

-(void) getNewXml
{
	//NSLog(@"xml");
	
	NSString* server = @"http://72.47.200.205/xml/";
	
	NSString* file = [[NSString stringWithFormat:@"%.3fi%.3f",lastLatitude,lastLongitude] retain];
	NSString* fileTemp = [NSString stringWithFormat:@"%@%@.xml?udid=%@", server, [file stringByReplacingOccurrencesOfString:@"." withString:@"_"],udid];
	
	NSURL* url = [NSURL URLWithString:fileTemp];
	
	@synchronized(self) {
		
		NSString* xml = [NSString stringWithContentsOfURL:url];
		
		if (xml != nil)
		{
			[_TLCouponsXmlParser xmlToCoupons:coupons:xml:lastLatitude:lastLongitude];
			
			//remove coupons already shown and dismissed by the user
			[self removeDismissed:coupons];
			
			if ([coupons count] > 0)
			{
				_TLCoupon* cp = [coupons objectAtIndex:0];
								
				[currentCoupon release];
				currentCoupon = [cp retain];
					 
				[self showNearby];
			}
		}
	}
}


-(void)timer
{
	//NSLog(@"timer");
	
	if (lastLatitude != 0)
	{
		if (![self isOpened] && (!movingNearbyIn) && (nearby.frame.origin.x == 320))
			[self getNewXml];
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	lastLatitude = newLocation.coordinate.latitude;
	lastLongitude = newLocation.coordinate.longitude;
	
	[self timer];
}

-(_TLCoupon*)getCurrentCoupon
{
	return currentCoupon;
}

-(void)hide
{	
	if (movingNearbyIn)
	{
		[self showNearby];
	}
}

-(void)couponClick
{
	//hide stuff
	[self hide];
	
	[self setScreen:@"SCREEN_DEAL":false];
}

-(void)flashClick
{
	//hide stuff
	[self hide];
	
	[self setScreen:@"SCREEN_DEAL":false];
}

-(void) dealloc
{
	[locationManager release];
	[nearby release];

	for (int i=[coupons count]-1;i>=0;i--)
		[[coupons objectAtIndex:i] release];
	
	[coupons release];
	
	[dView release];
	[mView release];
	[sView release];	
	[smView release];
	[cView release];	
	[udid release];
	
	[super dealloc];
}

-(double)getDistanceFromStore
{
	_TLStore* store = [[currentCoupon getStores] objectAtIndex:0];
	
    int nRadius = 6371; // Earth's radius in Kilometers
    // Get the difference between our two points
    // then convert the difference into radians
    double nDLat = (store.latitude - lastLatitude) * (M_PI/180);
    double nDLon = (store.longitude - lastLongitude) * (M_PI/180);
    double nA = pow ( sin(nDLat/2), 2 ) + cos(lastLatitude) * cos(store.latitude) * pow ( sin(nDLon/2), 2 );
	
    double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
    double nD = nRadius * nC;
	
    return nD; // Return our calculated distance
}

-(void)sendLog:(int) action:(NSString*)email
{
	//avoid to do it twice
	if ([_TLRMSTracker loadSafeString:[NSString stringWithFormat:@"%i_%i",action,currentCoupon.idcoupon]] == nil)
	{
		//save
		[_TLRMSTracker saveString:[NSString stringWithFormat:@"%i_%i",action,currentCoupon.idcoupon]:@"1"];
		
		if (email == nil)
			email = @"";

		//mount the url
		NSString* actionUrl = [NSString stringWithFormat:@"http://72.47.200.205:8080/tapplocaladmin/logger?id_coupon=%i&action=%i&udid=%@&lat=%.7f&lon=%.7f&email=%@&id_merchant=%i&id_representative=%i&id_store=%i&code=%@",
							   currentCoupon.idcoupon,action,udid,lastLatitude,lastLongitude,email,[currentCoupon getMerchant].idmerchant,[currentCoupon getMerchant].idrepresentative,((_TLStore*)[[currentCoupon getStores] objectAtIndex:0]).idstore,code ];
		
		NSURL* url = [NSURL URLWithString:actionUrl];
		
		//call the get
		[NSString stringWithContentsOfURL:url];
		
		if (action == TL_ACTION_UNFOLLOW)
			[_TLRMSTracker deleteRecordstore:[NSString stringWithFormat:@"%i_%i",TL_ACTION_FOLLOW,currentCoupon.idcoupon]];
		else if (action == TL_ACTION_FOLLOW)
			[_TLRMSTracker deleteRecordstore:[NSString stringWithFormat:@"%i_%i",TL_ACTION_UNFOLLOW,currentCoupon.idcoupon]];
	}
}

-(NSMutableArray*) getCoupons
{
	return coupons;
}

-(void)selectCoupon:(int) newIndex
{
	[currentCoupon release];
	currentCoupon = [[coupons objectAtIndex:newIndex] retain];
}

@end
