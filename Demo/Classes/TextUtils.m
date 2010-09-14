//
//  TextUtils.m
//  Hello3
//
//  Created by Guilherme Carvalho on 20/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "TextUtils.h"
#import "ByteUtils.h"
#import "NSDataBase64.h"
#import <Foundation/Foundation.h>


@implementation TextUtils

+(NSString*) cgfloatToString: (CGFloat) floatNumber
{
	NSNumber* number = [NSNumber numberWithFloat:floatNumber];
	NSString* result = [number stringValue];
	
	return result;
}

+ (NSMutableString*) encodeBase64String:(NSString*) string {
	
	NSData *data2 = [ByteUtils getBytes:string];
	return [data2 base64EncodedString];
}

+(NSMutableString*) decodeBase64String:(NSString*) string
{	
	NSData *data2 = [NSData dataFromBase64String:string]; 
	
	return [[NSMutableString alloc]initWithBytes:[data2 bytes] length:[data2 length] encoding:NSISOLatin1StringEncoding]; 
}

+(NSString*) insertParameters:(NSString*) url: (NSArray*) parameters 
{	
	if (parameters != nil)
	{
		for (int i=0; i<[parameters count]; i++)
		{
			NSString* parameter = (NSString*) [parameters objectAtIndex:i];
			
			url = [self appendParameterInUrl:url:parameter];
		}
	}
	
	return url;
}


+(NSString*) appendParameterInUrl:(NSString*) url: (NSString*) parameter
{
	NSMutableString* result = [[NSMutableString alloc]initWithString:url];
	
	 if ((parameter != nil) && (![[parameter stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]))
	 {
		 if ([self indexOf:url:@"?"] >= 0){
			 [result appendString:@"&"];
			 [result appendString: parameter];
		}else{
			[result appendString:@"?"];
			[result appendString: parameter];
		}				
	}
	return result;
}
			
+(int) indexOf:(NSString*) base: (NSString*) searched
{
	NSRange toprange = [base rangeOfString: searched];
	
	if (toprange.length > 0)
		return toprange.location;
	else
		return -1;
}

+(NSString*) replaceText:(NSString*) base: (NSString*) token: (NSString*) replaceString
{
	NSMutableString* result = [[NSMutableString alloc] initWithString:base];
	
	if ((result == nil) || ([self indexOf: result: token] < 0))
		return result;
	
	int systemBreak = 100;
	
	while ( ([self indexOf: result: token] >= 0) && (systemBreak > 0))
	{
		NSMutableString* newResult = [[NSMutableString alloc] initWithString:[result substringWithRange:NSMakeRange(0, [self indexOf:result :token])]];
		[newResult appendString:replaceString];
		[newResult appendString:[result substringFromIndex:[self indexOf:result :token]+[token length]]];
		[result release];
		result = newResult;
		systemBreak--;
	}
	
	return result;
}

@end
