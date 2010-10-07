//
//  TappLocal.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 04/10/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "_TLResourceManager.h"
#import "_TLColorUtils.h"
#import "_TLMapView.h"
#import "_TLDealView.h"
#import "_TLStoreView.h"
#import "_TLSingleMapView.h"
#import "_TLConfirmedView.h"
#import "_TLCoupon.h" 
#import "_TLCouponsXmlParser.h"
#import "FontLabel.h"
#import "FontManager.h"

@interface TappLocal : NSObject<UITabBarDelegate, UIAlertViewDelegate, CLLocationManagerDelegate> {
	_TLDealView* dView;
	_TLMapView* mView;
	_TLStoreView* sView;
	_TLSingleMapView* smView;
	_TLConfirmedView* cView;
	NSString* lastXml;
	_TLCoupon* currentCoupon;
	BOOL working;
	float lastLatitude;
	float lastLongitude;
	UIViewController* vc;
	
	BOOL movingNearbyIn;
	BOOL movingFlashIn;
	UIButton* nearby;
	UIButton* flash;	
	FontLabel* flashText;
	
	NSString* file;
	
	NSTimer* clock;
	int count;
}

@property(readonly,retain) UIViewController* vc;
@property(readonly,assign) float lastLatitude;
@property(readonly,assign) float lastLongitude;

-(TappLocal*) init:(UIViewController*)v;
+(TappLocal*) instanceWithController:(UIViewController*) v;
+(TappLocal*) instance;
-(void)setScreen:(NSString*) newScreen:(bool)isBack;
-(void)closeCoupons;
-(_TLCoupon*)getCurrentCoupon;
-(double)getDistanceFromStore;
-(void)timer;

@end
