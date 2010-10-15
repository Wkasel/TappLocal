//
//  UpcomingNormalView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"
#import "_TLRMSTracker.h"
#import "_TLCoupon.h"
#import "_TLTappLocalView.h"
#import "_TLRMSTracker.h"

@interface _TLDealView : NSObject {
	
	id tl;
		
	_TLTappLocalView* mother;
	UIImageView* bg;
	
	UINavigationBar* top;
	UIButton* close;

	UILabel* special;
	UIButton* merchantlogoFrame;	
	UIButton* merchantlogo;	

	/*UILabel**/UILabel* text1;
	UILabel* text2;
	UILabel* text3;
	
	UIButton* directions;
	UIButton* nothanks;
	UIButton* moredeals;
	
	UIButton* taptouse;
	
	UILabel* text4;
	UILabel* text5;
	
	_TLCoupon* coupon;
	
	BOOL isBuilt;
}

-(void) configure:(id) parent;
-(void) merchantClick;
-(void) closeClick;
-(void) tapToUseClick;
-(void) moreDealsClick;
-(void) noThanksClick;

@end
