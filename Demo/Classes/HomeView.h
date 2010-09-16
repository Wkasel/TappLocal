//
//  PastView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "ColorUtils.h"
#import "ResourceManager.h"
#import "TappLocalView.h"

@interface HomeView : NSObject<UITableViewDelegate,UITableViewDataSource> {
	UIViewController* controller;
	
	UIView* mother;
	UIImageView* bg;
	UIImageView* logo;	
	
	FontLabel* text;
	FontLabel* link;
	UIView* underline;
	UIButton* button;
	
	UITableView* table;
	
	UIButton* nearby;
	UIButton* flash;	
	FontLabel* flashText;

	FontLabel* boxtext;

	BOOL isBuilt;
	BOOL movingNearbyIn;
	BOOL movingFlashIn;
}

-(void) configure:(UIViewController*) parent;
-(void) sendEmail;
-(void) couponClick;
-(void) flashClick;


@end
