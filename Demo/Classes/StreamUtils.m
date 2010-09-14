//
//  StreamUtils.m
//  Hello3
//
//  Created by Guilherme Carvalho on 20/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "StreamUtils.h"
#import <Foundation/Foundation.h>


@implementation StreamUtils

+(NSMutableData*) readFully:(NSInputStream*) stream: (int) maxSize
{		
	//declara o vetor
	NSMutableData* temp = [[NSMutableData alloc]init];
	NSMutableData* result = [[NSMutableData alloc]init];
	
	int alreadyRead = 0;
	
	Boolean finished = false;
	
	while ((!finished) && (stream != nil) && ([stream streamStatus] == NSStreamStatusOpen))
	{
		Boolean hasBytes = [stream hasBytesAvailable];
		
		if (hasBytes)
		{						
			// read some bytes from the stream into our local buffer
			[temp setLength:16 * 1024];
			int read = [stream read:[temp mutableBytes] maxLength:maxSize-alreadyRead];
			[temp setLength:read];
			
			if (read == 0)
			{
				finished = true;
			}
			else
			{
				[result appendBytes:[temp mutableBytes] length:[temp length]];
				alreadyRead += read;					
			}
		}
		
		if (alreadyRead >= maxSize)
			finished = true;			
	}			
	
	return result;
}

@end
