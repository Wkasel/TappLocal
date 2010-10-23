//
//  UpcomingGameView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"
#import <MapKit/MapKit.h>
#import "_TLMapStoreAnnotation.h"
#import "_TLCoupon.h"
#import "_TLTappLocalView.h"

@interface _TLMapView : NSObject<CLLocationManagerDelegate, MKMapViewDelegate> {
	id tl;
	
	_TLTappLocalView* mother;
	MKMapView* map;

	UINavigationBar* top;
	UIButton* close;
	
	_TLCoupon* coupon;
	
	BOOL isBuilt;
	BOOL placed;
}

-(void) configure:(id) parent;
-(void) backClick;
-(void) closeClick;
-(void) merchantClick:(id)sender;

@end
