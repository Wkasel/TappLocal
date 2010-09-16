//
//  UpcomingNormalView.h
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
#import "FBConnect.h"
#import "Coupon.h"
#import "TappLocalView.h"

@interface DealView : NSObject<FBSessionDelegate, FBRequestDelegate> {
	
	UIViewController* controller;
		
	TappLocalView* mother;
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
	
	Coupon* coupon;
	
	BOOL isBuilt;
}

-(void) configure:(UIViewController*) parent;
-(void) merchantClick;
-(void) closeClick;
-(void) tapToUseClick;
-(void) likeClick;
-(void) moreDealsClick;

@end
