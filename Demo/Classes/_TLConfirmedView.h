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
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "_TLTappLocalView.h"
#import "_TLCoupon.h"

@interface _TLConfirmedView : NSObject<ABPeoplePickerNavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
	id tl;
	
	_TLTappLocalView* mother;
	UIImageView* bg;
	
	FontLabel* show;	
	
	UIButton* merchantlogo;	
	
	FontLabel* title;
	FontLabel* text1;
	FontLabel* text2;
	FontLabel* text3;
	
	UIButton* sendMe;	
	
	_TLCoupon* coupon;
	
	UIButton* close;
	
	UITextField* tv;
	
	BOOL isBuilt;
}

-(void) configure:(id) parent;
-(void) seemoreClick;
-(void) moreoffersClick;
-(void) sharefriendsClick;
-(void) closeClick;
-(void) sendMeClick;

@end
