//
//  ColorUtils.m
//  Hello3
//
//  Created by Guilherme Carvalho on 29/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "ColorUtils.h"


@implementation ColorUtils


+(UIColor*) colorFromRGB:(NSString*) value
{
	NSString* red = [value substringWithRange:NSMakeRange(0, 2)];
	NSString* green = [value substringWithRange:NSMakeRange(2, 2)];
	NSString* blue = [value substringWithRange:NSMakeRange(4, 2)];
	NSString* alpha = @"FF";
	
	if ([value length] == 8)
		alpha = [value substringWithRange:NSMakeRange(6, 2)];		
	
	unsigned redint;
	unsigned greenint;
	unsigned blueint;
	unsigned alphaint;
	
	[[NSScanner scannerWithString: red] scanHexInt: &redint];
	[[NSScanner scannerWithString: green] scanHexInt: &greenint];	
	[[NSScanner scannerWithString: blue] scanHexInt: &blueint];	
	[[NSScanner scannerWithString: alpha] scanHexInt: &alphaint];	
	
	return [[UIColor alloc] initWithRed:redint/255.0 green:greenint/255.0 blue:blueint/255.0 alpha:alphaint/255];
}

+(UIColor*) randomColor
{
	return [[UIColor alloc] initWithRed:(rand() % 1000)/1000.0 green:(rand() % 1000)/1000.0 blue:(rand() % 1000)/1000.0 alpha:1];
}




@end
