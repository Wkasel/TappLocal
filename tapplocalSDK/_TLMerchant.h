//
//  Merchant.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 14/09/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_TLStore.h"

@interface _TLMerchant : NSObject {
	int idmerchant;
	NSString* name;
	NSString* logo;
	NSString* description;
	NSString* phone;
	NSString* site;
	int idrepresentative;
}

@property(nonatomic, assign) int idmerchant;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* logo;
@property(nonatomic, retain) NSString* description;
@property(nonatomic, retain) NSString* phone;
@property(nonatomic, retain) NSString* site;
@property(nonatomic, assign) int idrepresentative;

@end
