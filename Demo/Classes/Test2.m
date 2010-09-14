//
//  Test2.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 26/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "Test2.h"


@implementation Test2

-(int)multiply2:(int)number1:(int)number2
{
	CLLocationManager* locationManager=[[CLLocationManager alloc]init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
	[locationManager startUpdatingLocation];
	
	return number1 + number2;
}

@end
