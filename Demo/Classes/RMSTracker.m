//
//  RMSTracker.m
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "RMSTracker.h"
#import "Constants.h"
#import "ByteUtils.h"

@implementation RMSTracker

+(NSMutableData*) loadSafe:(NSString*) name
{
	if ([self existRecordstore:name])
	{
		NSString* filePath = [self getFullFileName: name];	
		NSMutableData* result = [[NSMutableData alloc] initWithContentsOfFile:filePath];
		return result;
	}
	
	return nil;	
}

+(NSString*) loadSafeString:(NSString*) name
{
	if ([self existRecordstore:name])
	{
		NSString* filePath = [self getFullFileName: name];	
		NSString* result = [[NSString alloc] initWithContentsOfFile:filePath];
		return result;
	}
	
	return nil;
}

+(NSMutableData*) load:(NSString*) name
{
	NSString* filePath = [self getFullFileName: name];	
	NSMutableData* result = [[NSMutableData alloc] initWithContentsOfFile:filePath];
	return result;
}

+(void) saveString:(NSString*) name: (NSString*) data
{
	NSMutableData* result = [ByteUtils getBytes:data];
	NSString* filePath = [self getFullFileName: name];	
	[result writeToFile:filePath atomically:YES];
}

+(void) saveArray:(NSString*) name: (NSMutableArray*) data
{
	NSMutableString* buffer = [[NSMutableString alloc] init];
	
	for (int i=0; i<[data count];i++)
	{
		NSString* string = (NSString*) [data objectAtIndex:i];
		
		[buffer appendString:string];
		[buffer appendString:@"\n"];
	}
	
	[self saveString:name :buffer];
}

+(void) saveBytes:(NSString*) name: (NSMutableData*) data
{
	NSString* filePath = [self getFullFileName: name];	
	[data writeToFile:filePath atomically:YES];
}

+(void) clearRMS
{
	NSMutableArray* recordstores = [Constants getALL_RECORDSTORE_KEYS];
	
	for (int i=0; i<[recordstores count];i++)
	{
		NSString* fileName = (NSString*)[recordstores objectAtIndex:i];
		
		[self deleteRecordstore:fileName];
	}
}

+(void) deleteRecordstore:(NSString*) recordstoreName
{
	NSString *filePath = [self getFullFileName: recordstoreName];	
	
	// Get pointer to file manager.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// If the file does not exist, copy it from the app bundle.
	if ([fileManager fileExistsAtPath:filePath])
		[fileManager removeItemAtPath:filePath error:NULL];
}

+(Boolean) existRecordstore:(NSString*) name
{
	NSString *filePath = [self getFullFileName: name];
	
	// Get pointer to file manager.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// If the file does not exist, copy it from the app bundle.
	return [fileManager fileExistsAtPath:filePath];
}

+(NSString*) getFullFileName:(NSString*) name
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:name];
	return filePath;
}

@end
