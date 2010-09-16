//
//  Coupon.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "Coupon.h"


@implementation Coupon

@synthesize idcoupon;
@synthesize agefrom;
@synthesize ageto;
@synthesize title;
@synthesize text;
@synthesize dates;
@synthesize location;
@synthesize logo;
@synthesize sex;

-(Merchant*) getMerchant
{
	return merchant;
}

-(void) setMerchant:(Merchant*) m
{
	merchant = m;
}

-(NSMutableArray*) getStores
{
	if (stores == nil)
		stores = [[NSMutableArray alloc]init];
	
	return stores;
}

-(void) addStore:(Store*) s
{
	[[self getStores] addObject:s];
}

@end
