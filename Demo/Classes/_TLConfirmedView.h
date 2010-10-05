//
//  ConfirmedView.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontLabel.h"
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"
#import "FBConnect.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "_TLTappLocalView.h"

@interface _TLConfirmedView : NSObject<FBSessionDelegate,ABPeoplePickerNavigationControllerDelegate> {
	id tl;
	
	_TLTappLocalView* mother;
	UIImageView* bg;
	
	UIButton* seemore;	
	UIButton* moreoffers;	
	UIButton* sharefriends;	
	UIButton* follow;
	
	UIButton* close;
	
	BOOL isBuilt;
}

-(void) configure:(id) parent;
-(void) seemoreClick;
-(void) moreoffersClick;
-(void) sharefriendsClick;
-(void) followClick;
-(void) closeClick;

@end
