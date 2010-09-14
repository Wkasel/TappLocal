//
//  CacheManager.m
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "CacheManager.h"
#import "ResourceManager.h"
#import "Constants.h"
#import "RMSTracker.h"
#import "TextUtils.h"
#include <stdlib.h>


@implementation CacheManager

static CacheManager *gInstance = nil;

-(CacheManager*) init
{
	[super init];
	
	//busca as informaÁıes do jad
	[self persistInfoFromJad];
	
	indexUrlVector = [[NSMutableArray alloc] init];
	errorImageUrls = [[NSMutableArray alloc] init];
	
	//recupera da rms a configuraÁ„o antiga da cachemanager 
	NSString* managerString = [RMSTracker loadSafeString:RECORDSTORE_CACHE_MANAGER];
	
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
			NSArray* temp = [entryTemp componentsSeparatedByString: CACHE_SEPARATOR];
			
			NSMutableArray* entry = [[NSMutableArray alloc]init];
			[entry addObject:[temp objectAtIndex:0]];
			[entry addObject:[temp objectAtIndex:1]];
						
			//adiciona o elemento
			[indexUrlVector addObject:entry];
		}	
	}
	
	return self;
}


+(CacheManager *)instance
{
    @synchronized(self)
    {
        if (gInstance == nil)
            gInstance = [[self alloc] init];
    }
    return(gInstance);
}

+(CacheManager *)remakeInstance
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
		[sb appendString:CACHE_SEPARATOR];
		[sb appendString:(NSString*)[entry objectAtIndex:1]];
		
		//se nao for a ˙ltima linha, adiciona um \n
		if ( i != [indexUrlVector count]-1)
			[sb appendString:@"\n"];						
	}	
	
	//grava
	[RMSTracker saveString:RECORDSTORE_CACHE_MANAGER: sb];
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
		[RMSTracker saveBytes:nextRandom: data];
		
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
			NSMutableData* result = [RMSTracker loadSafe:[entry objectAtIndex:1]];;
			
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
			NSMutableData* result = [ResourceManager getResourceBinaryFile:@"error.jpg"];
			
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
			[RMSTracker deleteRecordstore:[entry objectAtIndex:1]];
			[indexUrlVector removeObjectAtIndex:i];
			
			//atualiza o indice da cache
			[self persist];
			
			break;
		}
	}
}	

-(void) persistInfoFromJad
{			
	//recupera as chaves que devem ser carregadas automaticamente
	for (int i=0; i<[[Constants getAUTOLOADING_RECORDSTORE_KEYS] count]; i++)
	{
		//para cada uma
		NSString* key = [[Constants getAUTOLOADING_RECORDSTORE_KEYS] objectAtIndex:i];
		NSMutableString* keyResource = [[NSMutableString alloc]initWithString:key];
		[keyResource appendString:@".i"];
				
		//se nao existe no rms,
		if ([RMSTracker loadSafeString:key] == nil)
		{
			//ve se veio no jad e se veio, persiste ele
			if ([ResourceManager getResourceTextFile:keyResource] != nil)
				[RMSTracker saveString:key: [ResourceManager getResourceTextFile:keyResource]];
		}
	}
}

@end
