//
//  SingleMapView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 19/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "SingleMapView.h"
#import "TappLocalViewController.h"

@implementation SingleMapView

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
		map.multipleTouchEnabled =TRUE;
		map.userInteractionEnabled = TRUE;
		map.delegate = self;
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
	}
	
	for (int i=[[map annotations] count]-1; i>=0; i--)
	{
		MapStoreAnnotation* temp = (MapStoreAnnotation*) [[map annotations] objectAtIndex:i];
		[map removeAnnotation:temp];
	}
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	region.center.latitude = coupon.latitude;
	region.center.longitude = coupon.longitude;
	span.latitudeDelta= 0.005;
	span.longitudeDelta= 0.005;
	region.span = span;
	[map setRegion:region animated: TRUE];
	
	CLLocationCoordinate2D location;
	location.latitude = coupon.latitude;
	location.longitude = coupon.longitude;
	MapStoreAnnotation* mark = [[MapStoreAnnotation alloc]initWithCoordinate:location title:coupon.title subtitle:coupon.text];
	[map addAnnotation:mark];
	
	[controller.view addSubview:mother];
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
	[(TappLocalViewController*)controller setScreen:coupon.storename:false];
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

-(void) setCoupon:(Coupon*) c
{
	coupon = c;
}

@end
