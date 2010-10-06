//
//  SingleMapView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 19/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLSingleMapView.h"
#import "TappLocalViewController.h"
#import "TappLocal.h"

@implementation _TLSingleMapView

-(void) configure:(id) parent
{
	tl = parent;
	
	coupon = [(TappLocal*)tl getCurrentCoupon];
	
	if (!isBuilt)
	{
		CLLocationManager* locationManager=[[CLLocationManager alloc]init];
		locationManager.delegate = self;
		locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
		[locationManager startUpdatingLocation];
		
		isBuilt = true;
		
		mother = [[_TLTappLocalView alloc]init];
		mother.frame = CGRectMake(0, 0, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		wv = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
		[mother addSubview:wv];
		
		plate  = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		plate.backgroundColor = [UIColor blackColor];
		[mother addSubview:plate];	
		
		top = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		top.barStyle = UIBarStyleBlackTranslucent;
		[mother addSubview:top];	
		
		UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
		UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"Stores"];
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
	}
	
	[((TappLocal*)tl).vc.view addSubview:mother];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?f=d&source=s_d&saddr=%f+%f&daddr=%f+%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude,38.05,-122.26];
	NSURLRequest* requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	[wv loadRequest:requestObj];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	NSLog(@"annotation %@",[annotation title]);
	
	if (![[annotation title] isEqualToString:@"Current Location"])
	{
		MKAnnotationView *annotationView = nil;
		
		MKPinAnnotationView *startPin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"] autorelease];
		startPin.animatesDrop = YES;
		
		UIButton* b = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[b addTarget:self action:@selector(merchantClick) forControlEvents:UIControlEventTouchUpInside];
		
		startPin.rightCalloutAccessoryView = b;
		startPin.canShowCallout = YES;
		startPin.enabled = YES;
		
		UIImage *image = [[UIImage alloc] initWithData:[_TLResourceManager getResourceBinaryFile:@"Icon.png"]];
		UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
		[imgView setFrame:CGRectMake(0, 0, 30, 30)];
		startPin.leftCalloutAccessoryView = imgView;
		
		annotationView = startPin;
		return annotationView;
	}
	
	return nil;
}

-(void) merchantClick
{
	[(TappLocal*)tl setScreen:@"SCREEN_STORE":false];
}

-(void) backClick
{
	[mother removeFromSuperview];
}

-(void) closeClick
{
	[(TappLocal*)tl closeCoupons];
}

-(void) removeFromSuperview
{
	[mother removeFromSuperview];
}

-(void) dealloc
{
	[mother release];
	[wv release];
	[plate release];
	[top release];
	[close release];
	
	[super dealloc];
}

@end
