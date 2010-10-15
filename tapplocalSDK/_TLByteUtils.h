//
//  ByteUtils.h
//  Hello3
//
//  Created by Guilherme Carvalho on 19/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSArray.h>


@interface _TLByteUtils : NSObject {

}

+(int) getLengthOfMessage:(NSArray*) listPackOfMessage;

+(NSMutableData*) extractByteArray:(NSMutableData*) buffer: (int) start: (int) end;

+(int) getIntFromPartOfFrontPack:(NSMutableData*) message: (int) start: (int) end;

+(NSMutableData*) intToByteArray:(int) value;
						   
+(int) byteArrayToInt:(NSMutableData*) b;

+(NSMutableData*) reverse:(NSMutableData *)b;

+(NSMutableData*) getBytes:(NSString*) string;


@end
