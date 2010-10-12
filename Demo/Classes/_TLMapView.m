//
//  UpcomingGameView.m
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLMapView.h"
#import "TappLocalViewController.h"
#import "_TL.h"

@implementation _TLMapView

-(void) configure:(id) parent
{
	tl = parent;
	
	coupon = [(_TL*)tl getCurrentCoupon];
	
	if (mother != nil)
	{
		[map removeFromSuperview];
		[map release];
		
		[top removeFromSuperview];
		[top release];	
		
		[mother removeFromSuperview];
		[mother release];	
	}

	mother = [[_TLTappLocalView alloc]init];
	mother.frame = CGRectMake(0, 0, 320, 480);
	mother.backgroundColor = [UIColor clearColor];
	
	map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	map.mapType = MKMapTypeStandard;
	map.delegate = self;
	map.multipleTouchEnabled =TRUE;
	map.userInteractionEnabled = TRUE;
	map.showsUserLocation = TRUE;
	[mother addSubview:map];
	
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
	
	for (int i=[[map annotations] count]-1; i>=0; i--)
	{
		_TLMapStoreAnnotation* temp = (_TLMapStoreAnnotation*) [[map annotations] objectAtIndex:i];
		[map removeAnnotation:temp];
	}
	
	for (int i=0; i<[[coupon getStores] count]; i++)
	{
		_TLStore* store = (_TLStore*)[[coupon getStores] objectAtIndex:i];
		
		CLLocationCoordinate2D location;
		location.latitude = store.latitude;
		location.longitude = store.longitude;
		_TLMapStoreAnnotation* mark = [[_TLMapStoreAnnotation alloc]initWithCoordinate:location title:coupon.title subtitle:coupon.text];
		[map addAnnotation:mark];
	}
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta= 0.005;
	span.longitudeDelta= 0.005;
	region.center.latitude = [(_TL*)tl lastLatitude];
	region.center.longitude = [(_TL*)tl lastLongitude];
	region.span = span;
	[map setRegion:region animated: TRUE];
	
	[((_TL*)tl).vc.view addSubview:mother];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
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
	[(_TL*)tl setScreen:@"SCREEN_STORE":false];
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

-(void) dealloc
{
	[mother release];
	[map release];
	[top release];
	[close release];
	
	[super dealloc];
}

@end
