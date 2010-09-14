//
//  ByteUtils.m
//  Hello3
//
//  Created by Guilherme Carvalho on 19/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "ByteUtils.h"
#import <Foundation/NSArray.h>

@implementation ByteUtils

+(int) getLengthOfMessage:(NSArray*) listPackOfMessage
{
	int count = 0;
	
	for (int i=0; i<[listPackOfMessage count]; i++)
	{
		NSMutableData* data = (NSMutableData*)[listPackOfMessage objectAtIndex:i];
	
		count += [self getIntFromPartOfFrontPack:data :16 :20] - 24;
	}
	
	return count;
}

+(NSMutableData*) extractByteArray:(NSMutableData*) buffer: (int) start: (int) end
{
	void* buf = malloc(end-start);
	[buffer getBytes:buf range:NSMakeRange(start, end-start)];
	
	NSMutableData* temp = [[NSMutableData alloc] initWithBytes:buf length:end-start];
	
	return temp;
}

+(int) getIntFromPartOfFrontPack:(NSMutableData*) message: (int) start: (int) end;
{
	NSMutableData* temp = [self extractByteArray:message :start :end];
	
	int result = [self byteArrayToInt:temp];
	
	return result;
}

+(NSMutableData*) intToByteArray:(int) value;
{
	return [self reverse:[NSMutableData dataWithBytes: &value length: sizeof(value)]];
}

+(NSMutableData*) reverse:(NSMutableData *)b
{
	char* oldBytes = (char *)[b bytes];	
	char* newBytes = (char*)malloc([b length]);
	
	for (int i=0; i<[b length];i++)
	{
		newBytes[i] = oldBytes[[b length]-1-i];
	}
		 
	return [[NSMutableData alloc]initWithBytes:newBytes length:[b length]];
}

+(int) byteArrayToInt:(NSMutableData*) b;
{
	int i;
	[[self reverse:b] getBytes: &i length: sizeof(i)];
	
	return i;
}

+(NSData*) getBytes:(NSString*) string
{
	NSData* response =[string dataUsingEncoding:NSISOLatin1StringEncoding];

	return response;
}

@end
