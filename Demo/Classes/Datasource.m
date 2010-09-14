//
//  Datasource.m
//  ContaDividida
//
//  Created by Guilherme Carvalho on 01/12/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "Datasource.h"
#import "DatasourceManager.h"
#import "Constants.h"

@implementation Datasource

-(Datasource*) initWithString:(NSString*) contents;
{
	[super init];
	
	if (contents != nil)
	{		
		NSArray* lines = [contents componentsSeparatedByString:@"\n"]; 
		
		if ([lines count] > 0)
		{
			NSString* tempCaptions = [lines objectAtIndex:0];
			
			NSArray* captionItems = [tempCaptions componentsSeparatedByString:@"||"];
			[[self getCaptions] addObjectsFromArray:captionItems];
		}
		
		[self getData];
		
		for (int i=1; i<[lines count]; i++)
		{		
			NSString* line = [lines objectAtIndex:i];
			
			NSArray* items = [line componentsSeparatedByString:@"||"];
			[[self getData] addObject:items];
			
		}
	}
	
	return self;
}

-(NSString*)toString
{
	NSMutableString* result =[[NSMutableString alloc] init];
	
	for (int i=0; i<[captions count];i++)
	{
		if (i != 0)
			[result appendString:@"||"];
			
		[result appendString:[captions objectAtIndex:i]];
	}
	
	for (int i=0; i<[data count];i++)
	{
		[result appendString:@"\n"];
		
		NSArray* array = [data objectAtIndex:i];
		
		for (int i=0; i<[array count];i++)
		{
			if (i != 0)
				[result appendString:@"||"];
			
			[result appendString:[array objectAtIndex:i]];
		}
	}
	
	return result;
}

-(NSString*) getName
{
	return name;
}

-(NSMutableArray*) getCaptions
{
	if (captions == nil)
		captions = [[NSMutableArray alloc]init];
	
	return captions;
}

-(NSMutableArray*) getData
{
	if (data == nil)
		data = [[NSMutableArray alloc]init];
	
	return data;
}

-(void) setName:(NSString*)newName
{
	name = newName;
}

-(void)updateIndex:(int)index:(NSArray*) values
{
	[data removeObjectAtIndex:index];
	[data insertObject:values atIndex:index];
}

-(void)deleteIndex:(int)index
{
//	NSLog(@"%i",[data count]);
	[data removeObjectAtIndex:index];
}

-(void)addIndex:(NSArray*) values
{
	[data addObject:values];
}

-(NSArray*)getIndex:(int) index
{
	return [data objectAtIndex:index];
}

-(void)deleteAll
{
	[data removeAllObjects];
}

@end
