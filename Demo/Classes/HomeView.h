//
//  PastView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"

@interface HomeView : NSObject {
	UIViewController* controller;
	
	UIView* mother;
	UIImageView* bg;
	UIImageView* logo;	
	
	FontLabel* text;
	FontLabel* link;
	UIView* underline;
	UIButton* button;

	FontLabel* boxtext;

	BOOL isBuilt;
}

-(void) configure:(UIViewController*) parent;

@end
