//
//  ResourceManager.m
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "ResourceManager.h"
#import "TextUtils.h"
#import "CacheManager.h"

@implementation ResourceManager

+(NSString*) getResourceTextFile:(NSString*) filename
{
	if ([TextUtils indexOf:filename :@"."] >= 0)
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
	if ([[CacheManager instance] getItem:filename] != nil)
		return [[CacheManager instance] getItem:filename];
	
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
		
		//adiciona na cache
		[[CacheManager instance] addItem:filename :result];
		
		return result;
	}
	
	return nil;
}

@end
