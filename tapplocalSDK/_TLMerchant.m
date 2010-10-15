//
//  Merchant.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 14/09/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLMerchant.h"


@implementation _TLMerchant

@synthesize idmerchant;
@synthesize name;
@synthesize logo;
@synthesize description;
@synthesize phone;
@synthesize site;
@synthesize idrepresentative;

-(void) dealloc
{
	[name release];
	[logo release];
	[description release];
	[phone release];
	[site release];
	[super dealloc];
}


@end
