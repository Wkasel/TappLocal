//
//  Coupon.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_TLMerchant.h"

@interface _TLCoupon : NSObject {

	int idcoupon;
	int agefrom;
	int ageto;
	NSString* title;
	NSString* text;
	NSString* dates;
	NSString* location;
	NSString* logo;
	NSString* sex;
	
	_TLMerchant* merchant;
	NSMutableArray* stores;
}

@property(nonatomic, assign) int idcoupon;
@property(nonatomic, assign) int agefrom;
@property(nonatomic, assign) int ageto;
@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* text;
@property(nonatomic, retain) NSString* dates;
@property(nonatomic, retain) NSString* location;
@property(nonatomic, retain) NSString* logo;
@property(nonatomic, retain) NSString* sex;

-(_TLMerchant*) getMerchant;
-(void) setMerchant:(_TLMerchant*) m;

-(NSMutableArray*) getStores;
-(void) addStore:(_TLStore*) s;

@end
