//
//  StoreView.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 18/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontLabel.h"
#import "_TLColorUtils.h"
#import "_TLResourceManager.h"
#import "FBConnect.h"
#import "TappLocalScreenProtocol.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "_TLStore.h"
#import "_TLCoupon.h"
#import "_TLMerchant.h"
#import "_TLTappLocalView.h"

@interface _TLStoreView : NSObject<UITableViewDelegate,UITableViewDataSource,FBSessionDelegate,ABPeoplePickerNavigationControllerDelegate> {
	id tl;
	
	_TLTappLocalView* mother;
	UIImageView* bg;
	
	UINavigationBar* top;
	UIButton* close;
	
	UIButton* merchantlogo;	
	UIButton* follow;		
	FontLabel* merchantname;
	
	UITableView* table;
	
	_TLCoupon* coupon;
	
	BOOL isBuilt;
}

-(void) configure:(id) parent;
-(void) backClick;
-(void) closeClick;
-(void) followClick;
-(void) facebookClick;
@end
