//
//  SingleMapView.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 19/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "ColorUtils.h"
#import "ResourceManager.h"
#import "RMSTracker.h"
#import <MapKit/MapKit.h>
#import "MapStoreAnnotation.h"
#import "TappLocalScreenProtocol.h"
#import "Coupon.h"
#import "TappLocalView.h"

@interface SingleMapView : NSObject<MKMapViewDelegate> {
	UIViewController* controller;
	
	TappLocalView* mother;
	MKMapView* map;
	
	UINavigationBar* top;
	UIButton* close;
	
	Coupon* coupon;
	
	BOOL isBuilt;
	
}

-(void) configure:(UIViewController*) parent;
-(void) backClick;
-(void) closeClick;
-(void) merchantClick;

@end
