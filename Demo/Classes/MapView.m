//
//  UpcomingGameView.m
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "MapView.h"
#import "TappLocalViewController.h"


@implementation MapView

-(void) configure:(UIViewController*) parent
{
	controller = parent;
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[TappLocalView alloc]init];
		mother.frame = CGRectMake(0, 0, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
		map.showsUserLocation = TRUE;
		map.mapType = MKMapTypeStandard;
		map.delegate = self;
		map.multipleTouchEnabled =TRUE;
		map.userInteractionEnabled = TRUE;
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
		label.textColor = [ColorUtils colorFromRGB:@"FFFFFF"];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.text = @"Back";
		label.font = [UIFont fontWithName:@"Arial-BoldMT" size:13.0f];
		[button addSubview:label];
		[button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
		button.frame = CGRectMake(5, 7, 50, 30);
		[mother addSubview:button];
		
		CLLocationManager* locationManager=[[CLLocationManager alloc]init];
		locationManager.delegate = self;
		locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
		[locationManager startUpdatingLocation];
	}
	
	for (int i=[[map annotations] count]-1; i>=0; i--)
	{
		MapStoreAnnotation* temp = (MapStoreAnnotation*) [[map annotations] objectAtIndex:i];
		[map removeAnnotation:temp];
	}
	
	
	for (int i=0; i<[coupons count]; i++)
	{
		Coupon* coupon = (Coupon*)[coupons objectAtIndex:i];
		
		CLLocationCoordinate2D location;
		location.latitude = coupon.latitude;
		location.longitude = coupon.longitude;
		MapStoreAnnotation* mark = [[MapStoreAnnotation alloc]initWithCoordinate:location title:coupon.title subtitle:coupon.text];
		[map addAnnotation:mark];
	}
	
	[controller.view addSubview:mother];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	if (!placed)
	{
		placed = true;
		
		MKCoordinateRegion region;
		MKCoordinateSpan span;
		
		float maxLat = 0;
		float maxLong = 0;
		
		for (int i=0; i<[coupons count]; i++)
		{
			Coupon* coupon = (Coupon*)[coupons objectAtIndex:i];		
			
			float latD = coupon.latitude-newLocation.coordinate.latitude;
			float lonD = coupon.longitude-newLocation.coordinate.longitude;
			
			if (latD < 0)
				latD *= -1.5;
			else
				latD *= 1.5;
			
			if (lonD < 0)
				lonD *= -1.5;	
			else
				lonD *= 1.5;
			
			if (latD > maxLat)
				maxLat = latD;
			
			if (lonD > maxLong)
				maxLong = lonD;
		}

		span.latitudeDelta= maxLat;
		span.longitudeDelta= maxLong;
		region.center.latitude = newLocation.coordinate.latitude;
		region.center.longitude = newLocation.coordinate.longitude;
		region.span = span;
		[map setRegion:region animated: TRUE];
	}
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
		
		UIImage *image = [[UIImage alloc] initWithData:[ResourceManager getResourceBinaryFile:@"Icon.png"]];
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
	[(TappLocalViewController*)controller setScreen:((Coupon*)[coupons objectAtIndex:0]).storename:false];
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

-(void) setCoupons:(NSMutableArray*) points;
{
	coupons = points;
}

@end
