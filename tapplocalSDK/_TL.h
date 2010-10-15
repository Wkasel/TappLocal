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


@interface _TL : NSObject<UITabBarDelegate, UIAlertViewDelegate, CLLocationManagerDelegate> {
	_TLDealView* dView;
	_TLMapView* mView;
	_TLStoreView* sView;
	_TLSingleMapView* smView;
	_TLConfirmedView* cView;
	
	_TLCoupon* currentCoupon;
	NSMutableArray* coupons;
	
	float lastLatitude;
	float lastLongitude;
	UIViewController* vc;
	
	BOOL movingNearbyIn;
	UIButton* nearby;

	NSTimer* clock;
	
	int refreshTime;
	
	CLLocationManager* locationManager;
	NSString* udid;
	NSString* code;
}

@property(readonly,retain) UIViewController* vc;
@property(readonly,assign) float lastLatitude;
@property(readonly,assign) float lastLongitude;
@property(readwrite,assign) int refreshTime;

extern int const TL_ACTION_FLAG;
extern int const TL_ACTION_VIEW;
extern int const TL_ACTION_DIRECTIONS;
extern int const TL_ACTION_NO_THANKS;
extern int const TL_ACTION_CLOSE;
extern int const TL_ACTION_MORE_DEALS;
extern int const TL_ACTION_USED_FAR;
extern int const TL_ACTION_USED_OK;
extern int const TL_ACTION_MERCHANT;
extern int const TL_ACTION_FOLLOW;
extern int const TL_ACTION_UNFOLLOW;

-(_TL*) initWithController:(UIViewController*)v:(NSString*)code;
-(void)start;
-(void)stop;

-(void)setScreen:(NSString*) newScreen:(bool)isBack;
-(void)closeCoupons;
-(_TLCoupon*)getCurrentCoupon;
-(double)getDistanceFromStore;
-(void)timer;
-(void)sendLog:(int) action:(NSString*)email;
-(NSMutableArray*) getCoupons;
-(void)selectCoupon:(int) newIndex;

@end
