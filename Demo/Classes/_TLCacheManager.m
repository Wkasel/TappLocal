//
//  CacheManager.m
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "_TLCacheManager.h"
#import "_TLResourceManager.h"
#import "_TLRMSTracker.h"
#import "_TLTextUtils.h"
#include <stdlib.h>


@implementation _TLCacheManager

static _TLCacheManager *gInstance = nil;

-(_TLCacheManager*) init
{
	[super init];
	
	indexUrlVector = [[NSMutableArray alloc] init];
	errorImageUrls = [[NSMutableArray alloc] init];
	
	//recupera da rms a configuraÁ„o antiga da cachemanager 
	NSString* managerString = [_TLRMSTracker loadSafeString:@"TL_RCM"];
	
	//se j· existia no rms, È preciso ler e se reconfigurar
	if (managerString != nil)
	{
		//quebra a string em linhas
		NSArray* entryVector = [managerString componentsSeparatedByString: @"\n"];
		
		//para cada linha
		for (int i=0; i<[entryVector count]; i++)
		{
			NSString* entryTemp = (NSString*)[entryVector objectAtIndex:i];
			
			//d· split no separador
			NSArray* temp = [entryTemp componentsSeparatedByString: @"@@@"];
			
			NSMutableArray* entry = [[NSMutableArray alloc]init];
			[entry addObject:[temp objectAtIndex:0]];
			[entry addObject:[temp objectAtIndex:1]];
						
			//adiciona o elemento
			[indexUrlVector addObject:entry];
		}	
	}
	
	return self;
}


+(_TLCacheManager *)instance
{
    @synchronized(self)
    {
        if (gInstance == nil)
            gInstance = [[self alloc] init];
    }
    return(gInstance);
}

+(_TLCacheManager *)remakeInstance
{
    @synchronized(self)
    {
		gInstance = [[self alloc] init];
    }
    return(gInstance);
}

-(NSString*) getNewRandomKey
{
	Boolean found = false;
	
	long next = 0;
	
	//enquanto nao achar
	while (!found)
	{
		found = true;
		
		//gera
		next = random();
		
		//verifica
		for (int i=0; i<[indexUrlVector count]; i++)
		{
			//recupera a entrada
			NSMutableArray* entry = (NSMutableArray*)[indexUrlVector objectAtIndex:i];
			
			NSString *strLong = [NSString stringWithFormat:@"%d", next];
			
			if ([strLong isEqualToString:(NSString*)[entry objectAtIndex:1]])
			{
				found = false;
				break;
			}
		}			
	}
	
	return [NSString stringWithFormat:@"%d", next];
}


/**
 * MÈtodo que persiste o estado atual do cacheManager no rms
 */
-(void) persist
{
	//cria um buffer para montar a string final
	NSMutableString* sb = [[NSMutableString alloc]init];
	
	//para cada linha
	for (int i=0; i<[indexUrlVector count]; i++)
	{
		//recupera a entrada
		NSMutableArray* entry = (NSMutableArray*)[indexUrlVector objectAtIndex:i];
		
		//escreve ela
		[sb appendString:(NSString*)[entry objectAtIndex:0]];
		[sb appendString:@"@@@"];
		[sb appendString:(NSString*)[entry objectAtIndex:1]];
		
		//se nao for a ˙ltima linha, adiciona um \n
		if ( i != [indexUrlVector count]-1)
			[sb appendString:@"\n"];						
	}	
	
	//grava
	[_TLRMSTracker saveString:@"TL_RCM": sb];
}

-(void) addErrorImageUrl:(NSString*) url
{
	[errorImageUrls addObject:url];
}


-(void) addItem:(NSString*) url: (NSMutableData*) data
{
	//verifica antes se a url nao existe 
	Boolean exists = false;
	
	//para cada linha
	for (int i=0; i<[indexUrlVector count]; i++)
	{
		//recupera a entrada
		NSMutableArray* entry = (NSMutableArray*)[indexUrlVector objectAtIndex:i];
		
		if ([url isEqualToString:(NSString*) [entry objectAtIndex:0]])
		{
			exists = true;
			break;
		}
	}
	
	if (!exists)
	{
		//gera um numero novo
		NSString* nextRandom = [self getNewRandomKey];
		
		//grava no rms
		[_TLRMSTracker saveBytes:nextRandom: data];
		
		//gera a nova entrada da cache
		NSMutableArray* newEntry = [[NSMutableArray alloc]init];
		[newEntry addObject:url];
		[newEntry addObject:nextRandom];

		//adiciona no vetor
		[indexUrlVector addObject:newEntry];	
		
		//atualiza o indice da cache
		[self persist];
	}			
}

/**
 * Recupera da cache um elemento
 * @param url
 * @return
 */
-(NSMutableData*) getItem:(NSString*) url
{
	//para cada linha
	for (int i=0; i<[indexUrlVector count]; i++)
	{
		//recupera a entrada
		NSMutableArray* entry = (NSMutableArray*)[indexUrlVector objectAtIndex:i];
		
		if ([url isEqualToString:(NSString*) [entry objectAtIndex:0]])
		{
			NSMutableData* result = [_TLRMSTracker loadSafe:[entry objectAtIndex:1]];;
			
			return result;
		}
	}
	
	//se chegou aqui e n„o achou, procura nos erros
	for (int i=0; i<[errorImageUrls count]; i++)
	{
		//recupera a entrada
		NSString* entry = (NSString*)[errorImageUrls objectAtIndex:i];
		
		if ([url isEqualToString:entry])
		{
			NSMutableData* result = [_TLResourceManager getResourceBinaryFile:@"error.jpg"];
			
			return result;
		}
	}		
	
	return nil;
}


-(void) deleteItem:(NSString*) url
{
	//para cada linha
	for (int i=0; i<[indexUrlVector count]; i++)
	{
		//recupera a entrada
		NSMutableArray* entry = (NSMutableArray*)[indexUrlVector objectAtIndex:i];

		if ([url isEqualToString:(NSString*) [entry objectAtIndex:0]])
		{
			[_TLRMSTracker deleteRecordstore:[entry objectAtIndex:1]];
			[indexUrlVector removeObjectAtIndex:i];
			
			//atualiza o indice da cache
			[self persist];
			
			break;
		}
	}
}	


@end
