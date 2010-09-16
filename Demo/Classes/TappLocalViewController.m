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
	
	[self turnGpsOn];
	
	[[FontManager sharedManager] loadFont:@"Digital"];
		
	dView = [[DealView alloc] init];
	hView = [[HomeView alloc] init];
	mView = [[MapView alloc] init];
	sView = [[StoreView alloc] init];
	smView = [[SingleMapView alloc] init];
	cView = [[ConfirmedView alloc] init];
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
	for (int i=[[self.view subviews] count]-1;i>=0;i--)
	{
		UIView* current = [[self.view subviews] objectAtIndex:i];
		
		if ([current isKindOfClass:[TappLocalView class]])
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
		NSMutableArray* coupons = [CouponsXmlParser xmlToCoupons:xml];
		
		int index = rand() % [coupons count]; 
			
		currentCoupon = [coupons objectAtIndex:index];
	}
}

-(Coupon*)getCurrentCoupon
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

@end
