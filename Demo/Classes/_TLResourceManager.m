//
//  ResourceManager.m
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "_TLResourceManager.h"
#import "_TLTextUtils.h"

@implementation _TLResourceManager

+(NSString*) getResourceTextFile:(NSString*) filename
{
	if ([_TLTextUtils indexOf:filename :@"."] >= 0)
	{	
		NSArray* array = [filename componentsSeparatedByString:@"."];
		
		NSString* name = (NSString*) [array objectAtIndex:0];
		NSString* extension = (NSString*) [array objectAtIndex:1];
		
		// Set path to the app bundle file.
		NSString* appBundleSettingsFilePath = [[NSBundle mainBundle] pathForResource:name ofType:extension];
					
		// Get pointer to file manager.
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		if ([fileManager fileExistsAtPath:appBundleSettingsFilePath])
		{		
			NSString* result = [[NSString alloc] initWithContentsOfFile:appBundleSettingsFilePath encoding:NSISOLatin1StringEncoding error:nil];
			return result;
		}	
	}
	
	return nil;
}	

+(NSMutableData*) getResourceBinaryFile:(NSString*) filename
{	
	//se chegou aqui eh porque nao tinha a parada
	NSArray* array = [filename componentsSeparatedByString:@"."];
	
	NSString* name = (NSString*) [array objectAtIndex:0];
	NSString* extension = (NSString*) [array objectAtIndex:1];
	
	// Set path to the app bundle file.
	NSString* appBundleSettingsFilePath = [[NSBundle mainBundle] pathForResource:name ofType:extension];
	
	// Get pointer to file manager.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:appBundleSettingsFilePath])
	{		
		NSMutableData* result = [[NSMutableData alloc] initWithContentsOfFile:appBundleSettingsFilePath];
		
		return result;
	}
	else if ([filename hasPrefix:@"http://"])
	{
		NSURL *url = [NSURL URLWithString:filename];
		NSMutableData *data = [NSMutableData dataWithContentsOfURL:url];
		
		return data;
	}
	
	return nil;
}

@end
