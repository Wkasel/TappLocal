//
//  Test.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 26/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "Test.h"
#import "Test2.h"


@implementation Test

@synthesize number1;
@synthesize number2;

-(int)multiply
{
	return [[[Test2 alloc] init] multiply2:2+number1:number2];
}

@end
