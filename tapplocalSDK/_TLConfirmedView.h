//
//  ConfirmedView.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "_TLTappLocalView.h"
#import "_TLCoupon.h"

@interface _TLConfirmedView : NSObject<UITextFieldDelegate, UIAlertViewDelegate> {
	id tl;
	
	_TLTappLocalView* mother;
	UIImageView* bg;
	
	UILabel* show;	
	
	UIButton* merchantlogo;	
	
	UILabel* title;
	UILabel* text1;
	UILabel* text2;
	UILabel* text3;
	
	UIButton* follow;	
	
	_TLCoupon* coupon;
	
	UIButton* close;
	
	UITextField* tv;
	UIButton *submitButton;
	
	BOOL isBuilt;
	
	NSString *emailRegex;
	NSPredicate *emailTest;
}

-(void) configure:(id) parent;
-(void) seemoreClick;
-(void) moreoffersClick;
-(void) closeClick;
-(void) followClick;
-(BOOL) validate;

@end
