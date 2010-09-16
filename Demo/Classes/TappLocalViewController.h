//
//  GameClockViewController.h
//  GameClock
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontLabel.h"
#import "FontManager.h"
#import "ResourceManager.h"
#import "ColorUtils.h"
#import "MapView.h"
#import "DealView.h"
#import "HomeView.h"
#import "RMSTracker.h"
#import "StoreView.h"
#import "SingleMapView.h"
#import "ConfirmedView.h"
#import "Coupon.h" 
#import "CouponsXmlParser.h"

@interface TappLocalViewController : UIViewController<UITabBarDelegate, UIAlertViewDelegate, CLLocationManagerDelegate> {

	DealView* dView;
	HomeView* hView;
	MapView* mView;
	StoreView* sView;
	SingleMapView* smView;
	ConfirmedView* cView;
	NSString* lastXml;
	
	Coupon* currentCoupon;
	BOOL working;
	
	float lastLatitude;
	float lastLongitude;
}

-(void)setScreen:(NSString*) newScreen:(bool)isBack;
-(void)closeCoupons;
-(Coupon*)getCurrentCoupon;
-(void)turnGpsOn;

@end

