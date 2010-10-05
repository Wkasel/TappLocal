//
//  Coupon.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLCoupon.h"


@implementation _TLCoupon

@synthesize idcoupon;
@synthesize agefrom;
@synthesize ageto;
@synthesize title;
@synthesize text;
@synthesize dates;
@synthesize location;
@synthesize logo;
@synthesize sex;

-(_TLMerchant*) getMerchant
{
	return merchant;
}

-(void) setMerchant:(_TLMerchant*) m
{
	merchant = m;
}

-(NSMutableArray*) getStores
{
	if (stores == nil)
		stores = [[NSMutableArray alloc]init];
	
	return stores;
}

-(void) addStore:(_TLStore*) s
{
	[[self getStores] addObject:s];
}

-(void) dealloc
{
	for (int i=0; i<[stores count];i++)
		[[stores objectAtIndex:i] release];
	
	[stores release];
	[title release];
	[text release];
	[dates release];
	[location release];
	[logo release];
	[sex release];
	[merchant release];	
	
	[super dealloc];
}

@end
