//
//  TappLocalAPI.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 07/10/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "TappLocalAPI.h"


@implementation TappLocalAPI
@synthesize running;

-(void)start
{	
	running = true;
	[tl start];
}

-(void)stop
{
	running = false;
	[tl stop];
}

-(TappLocalAPI*) initWithViewController:(UIViewController*)v:(NSString*)code
{
	[super init];
	
	tl = [[_TL alloc] initWithController:v:code];
	
	return self;
}

-(void) dealloc
{
	[tl release];

	[super dealloc];
}

-(void)setRefreshTimeNewAds:(int) seconds
{
	tl.refreshTime = seconds;
}

@end
