//
//  FlashView.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 20/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "ColorUtils.h"
#import "ResourceManager.h"
#import "RMSTracker.h"
#import "FBConnect.h"
#import "TappLocalView.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface FlashView : NSObject<FBSessionDelegate, ABPeoplePickerNavigationControllerDelegate> {
	
	UIViewController* controller;
	
	TappLocalView* mother;
	UIImageView* bg;
	
	UINavigationBar* top;
	UIButton* close;
	
	UIImageView* special;
	UIButton* merchantlogo;	

	UIButton* directions;
	UIButton* bring;
	UIButton* moredetails;
	
	UIButton* remindme;
	
	FontLabel* text4;
	FontLabel* text5;
	
	BOOL isBuilt;
}

-(void) configure:(UIViewController*) parent;
-(void) merchantClick;
-(void) closeClick;
-(void) remindmeClick;
-(void) bringClick;
-(void) moreDealsClick;

@end
