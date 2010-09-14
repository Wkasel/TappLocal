//
//  UpcomingGameView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "ColorUtils.h"
#import "ResourceManager.h"
#import "RMSTracker.h"
#import <MapKit/MapKit.h>
#import "MapStoreAnnotation.h"
#import "TappLocalScreenProtocol.h"
#import "TappLocalView.h"
#import "Coupon.h"

@interface MapView : NSObject<CLLocationManagerDelegate, MKMapViewDelegate> {
	UIViewController* controller;
	
	TappLocalView* mother;
	MKMapView* map;

	UINavigationBar* top;
	UIButton* close;
	
	NSMutableArray* coupons;
	
	BOOL isBuilt;
	BOOL placed;
}

-(void) configure:(UIViewController*) parent;
-(void) backClick;
-(void) closeClick;
-(void) merchantClick;
-(void) setCoupons:(NSMutableArray*) points;

@end
