//
//  UpcomingNormalView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"
#import "_TLRMSTracker.h"
#import "FBConnect.h"
#import "_TLCoupon.h"
#import "_TLTappLocalView.h"

@interface _TLDealView : NSObject<FBSessionDelegate, FBRequestDelegate> {
	
	id tl;
		
	_TLTappLocalView* mother;
	UIImageView* bg;
	
	UINavigationBar* top;
	UIButton* close;

	FontLabel* special;
	UIButton* merchantlogoFrame;	
	UIButton* merchantlogo;	

	FontLabel* text1;
	FontLabel* text2;
	FontLabel* text3;
	
	UIButton* directions;
	UIButton* savedeal;
	UIButton* moredetails;
	
	UIButton* taptouse;
	
	FontLabel* text4;
	FontLabel* text5;
	
	Facebook* facebook;
	
	_TLCoupon* coupon;
	
	BOOL isBuilt;
}

-(void) configure:(id) parent;
-(void) merchantClick;
-(void) closeClick;
-(void) tapToUseClick;
-(void) likeClick;
-(void) moreDealsClick;

@end
