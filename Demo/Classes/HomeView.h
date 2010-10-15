//
//  PastView.h
//  GameClock
//
//  Created by Guilherme Carvalho on 29/07/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TappLocalAPI.h"

@interface HomeView : NSObject {
	UIViewController* controller;
	
	UIView* mother;
	UIImageView* bg;
	UIImageView* logo;	
	
	UILabel* text;
	UILabel* link;
	UIView* underline;
	UIButton* button;

	UILabel* boxtext;

	BOOL isBuilt;
	
	TappLocalAPI* tl;
}

-(void) configure:(UIViewController*) parent;

@end
