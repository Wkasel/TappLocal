//
//  DatasourceManager.m
//  ContaDividida
//
//  Created by Guilherme Carvalho on 01/12/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "DatasourceManager.h"
#import "RMSTracker.h"
#import "ResourceManager.h"

@implementation DatasourceManager


+(Datasource*) getDatasource:(NSString*) name
{
	//NSLog(name);
	
	//cria o nome composto
	NSString* composedName = [[NSMutableString alloc] initWithFormat: @"%@%@",name,@".k"];
	
	//carrega do RMS
	NSString* resultString = [RMSTracker loadSafeString:composedName];
	
	//cria o result
	Datasource* result;
	
	//se nao tem no RMS
	if (resultString == nil)
	{
		//tenta carregar do resource
		resultString = [ResourceManager getResourceTextFile:composedName];
		
		//se achou
		if (resultString != nil)
		{
			//cria
			result = [[Datasource alloc]initWithString:resultString];
			
			//e coloca no rms
			[RMSTracker saveString:composedName :[result toString]];
		}

	}
	else
	{
		//se achou no rms, simplesmente cria
		result = [[Datasource alloc]initWithString:resultString];
	}
	
	if (result != nil)
		[result setName:[name copy]];
	
	return result;
}

+(void) saveDatasource:(Datasource*) datasource
{
	//NSLog([datasource getName]);//,[[datasource getCaptions] count]
	
	//cria o nome composto
	NSString* composedName = [[NSMutableString alloc] initWithFormat: @"%@%@",[datasource getName],@".k"];
	
	//e coloca no rms
	[RMSTracker saveString:composedName :[datasource toString]];
}
@end
