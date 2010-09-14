//
//  StoreView.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 18/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontLabel.h"
#import "ColorUtils.h"
#import "ResourceManager.h"
#import "FBConnect.h"
#import "TappLocalScreenProtocol.h"
#import "TappLocalView.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Store.h"

@interface StoreView : NSObject<UITableViewDelegate,UITableViewDataSource,FBSessionDelegate,ABPeoplePickerNavigationControllerDelegate> {
	UIViewController* controller;
	
	TappLocalView* mother;
	UIImageView* bg;
	
	UINavigationBar* top;
	UIButton* close;
	
	UIButton* merchantlogo;	
	UIButton* follow;		
	FontLabel* merchantname;
	
	UITableView* table;
	
	Store* store;
	
	BOOL isBuilt;
}

-(void) configure:(UIViewController*) parent;
-(void) backClick;
-(void) closeClick;
-(void) followClick;
-(void) facebookClick;
-(void) setStore:(Store*) s;
@end
