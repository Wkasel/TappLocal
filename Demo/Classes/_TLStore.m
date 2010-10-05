//
//  Store.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLStore.h"


@implementation _TLStore

@synthesize idstore;
@synthesize latitude;
@synthesize longitude;
@synthesize name;
@synthesize phone;
@synthesize address;


-(void) dealloc
{
	[name release];
	[phone release];
	[address release];
	[super dealloc];
}

@end
