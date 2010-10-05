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
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"
#import <MapKit/MapKit.h>
#import "_TLMapStoreAnnotation.h"
#import "TappLocalScreenProtocol.h"
#import "_TLCoupon.h"
#import "_TLTappLocalView.h"

@interface _TLSingleMapView : NSObject<MKMapViewDelegate> {
	id tl;
	
	_TLTappLocalView* mother;
	MKMapView* map;
	
	UINavigationBar* top;
	UIButton* close;
	
	_TLCoupon* coupon;
	
	BOOL isBuilt;
	
}

-(void) configure:(id) parent;
-(void) backClick;
-(void) closeClick;
-(void) merchantClick;

@end