//
//  ConfirmedView.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
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

@interface ConfirmedView : NSObject<FBSessionDelegate,ABPeoplePickerNavigationControllerDelegate> {
	UIViewController* controller;
	
	TappLocalView* mother;
	UIImageView* bg;
	
	UIButton* seemore;	
	UIButton* moreoffers;	
	UIButton* sharefriends;	
	UIButton* follow;
	
	UIButton* close;
	
	BOOL isBuilt;
}

-(void) configure:(UIViewController*) parent;
-(void) seemoreClick;
-(void) moreoffersClick;
-(void) sharefriendsClick;
-(void) followClick;
-(void) closeClick;

@end
