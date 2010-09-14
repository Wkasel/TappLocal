//
//  Constants.m
//  Hello3
//
//  Created by Guilherme Carvalho on 19/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import "Constants.h"

@implementation Constants

int const KEY_NOT_CAPTURED = 0;
int const KEY_CAPTURED = 1;
int const KEY_OPEN_INPUT_FORM = 2;

int const maxUsefullBytesInPacket = 4072;
int const packetHeaderLenght = 24;
int const lengthPack = 4096;
int idPack = 1;

int const MAX_CLIENT_REQUEST_HANDLER = 1000;

NSString* const DEGRADE_KIND_VERTICAL = @"v";
NSString* const DEGRADE_KIND_HORIZONTAL = @"h";
NSString* const DEGRADE_KIND_HORIZONTAL_MEIO = @"hM";
NSString* const DEGRADE_KIND_DIAGONAL = @"d";
NSString* const DEGRADE_KIND_DIAGONAL_INVERTIDA = @"dI";

NSString* const COMMAND_ENABLE_CONNECTION = @"EC";
NSString* const COMMAND_CLOSE_APPLICATION = @"CA";
NSString* const COMMAND_CLEAN_RMS = @"CR";
NSString* const COMMAND_RESET_APPLICATION = @"RA";
NSString* const COMMAND_OPEN_PAGE = @"OP";
NSString* const COMMAND_SHOW_ERROR = @"SE";
NSString* const COMMAND_SHOW_HELP = @"SH";
NSString* const COMMAND_SHOW_LOADING = @"SL";
NSString* const COMMAND_SHOW_MESSAGE = @"SM";
NSString* const COMMAND_SHOW_CONFIRMATION = @"SC";
NSString* const COMMAND_SEND_EMAIL = @"SEM";
NSString* const COMMAND_OPEN_BROWSER = @"OB";

NSString* const COMMAND_SELECT_DATASOURCE = @"SD";
NSString* const COMMAND_CLEAN_DATASOURCE = @"CD";

NSString* const COMMAND_ADD_RECORD_DATASOURCE = @"ARD";
NSString* const COMMAND_DELETE_RECORD_DATASOURCE = @"DRD";
NSString* const COMMAND_MODIFY_RECORD_DATASOURCE = @"MRD";
NSString* const COMMAND_SELECT_RECORD_DATASOURCE = @"SRD";

NSString* const RECORDSTORE_USER_ID = @"USER_ID";
NSString* const RECORDSTORE_USER_NAME = @"USER_NAME";
NSString* const RECORDSTORE_PASSWORD = @"PASSWORD";
NSString* const RECORDSTORE_APPLICATION_ID = @"APP_ID";
NSString* const RECORDSTORE_SERVER_IP = @"SERVER_IP";
NSString* const RECORDSTORE_SERVER_PORT = @"SERVER_PORT";
NSString* const RECORDSTORE_FIRST_PAGE = @"FIRST_PAGE";
NSString* const RECORDSTORE_FONT_SIZE = @"FONT_SIZE";
NSString* const RECORDSTORE_CACHE_MANAGER = @"CACHE_MANAGER";
NSString* const RECORDSTORE_LOADING_BG = @"LOADING_BG";
NSString* const RECORDSTORE_LOADING_FG = @"LOADING_FG";
NSString* const RECORDSTORE_LOADING_STRING = @"LOADING_STRING";
NSString* const RECORDSTORE_CANCEL_STRING = @"CANCEL_STRING";
NSString* const RECORDSTORE_OK_STRING = @"OK_STRING";
NSString* const RECORDSTORE_LANGUAGE = @"LANGUAGE";

NSString* const CACHE_SEPARATOR = @"@@@";

int const FONT_SIZE_SMALL = 15;
int const FONT_SIZE_MEDIUM = 18;
int const FONT_SIZE_LARGE = 20;

NSMutableArray* autoloading_keys = nil;
NSMutableArray* all_keys = nil;

+(NSMutableArray*) getAUTOLOADING_RECORDSTORE_KEYS
{
	if (autoloading_keys == nil)
	{
		autoloading_keys = [[NSMutableArray alloc] init];
	
		[autoloading_keys addObject:RECORDSTORE_USER_ID];
		[autoloading_keys addObject:RECORDSTORE_USER_NAME];
		[autoloading_keys addObject:RECORDSTORE_PASSWORD];
		[autoloading_keys addObject:RECORDSTORE_APPLICATION_ID];
		[autoloading_keys addObject:RECORDSTORE_SERVER_IP];
		[autoloading_keys addObject:RECORDSTORE_SERVER_PORT];
		[autoloading_keys addObject:RECORDSTORE_LOADING_BG];
		[autoloading_keys addObject:RECORDSTORE_LOADING_FG];
		[autoloading_keys addObject:RECORDSTORE_LOADING_STRING];
		[autoloading_keys addObject:RECORDSTORE_CANCEL_STRING];
		[autoloading_keys addObject:RECORDSTORE_OK_STRING];
		[autoloading_keys addObject:RECORDSTORE_FONT_SIZE];
		[autoloading_keys addObject:RECORDSTORE_FIRST_PAGE];
		[autoloading_keys addObject:RECORDSTORE_LANGUAGE];
	}
	return autoloading_keys;
}


+(NSMutableArray*) getALL_RECORDSTORE_KEYS
{
	if (all_keys == nil)
	{
		all_keys = [[NSMutableArray alloc] init];
	
		[all_keys addObject:RECORDSTORE_USER_ID];
		[all_keys addObject:RECORDSTORE_USER_NAME];
		[all_keys addObject:RECORDSTORE_PASSWORD];
		[all_keys addObject:RECORDSTORE_APPLICATION_ID];
		[all_keys addObject:RECORDSTORE_SERVER_IP];
		[all_keys addObject:RECORDSTORE_SERVER_PORT];
		[all_keys addObject:RECORDSTORE_LOADING_BG];
		[all_keys addObject:RECORDSTORE_LOADING_FG];
		[all_keys addObject:RECORDSTORE_LOADING_STRING];
		[all_keys addObject:RECORDSTORE_CANCEL_STRING];
		[all_keys addObject:RECORDSTORE_OK_STRING];
		[all_keys addObject:RECORDSTORE_FONT_SIZE];
		[all_keys addObject:RECORDSTORE_FIRST_PAGE];
		[all_keys addObject:RECORDSTORE_CACHE_MANAGER];
		[all_keys addObject:RECORDSTORE_LANGUAGE];
		
		//datasources desse projeto
		[all_keys addObject:@"pessoas.k"];
		[all_keys addObject:@"consumo.k"];
		[all_keys addObject:@"itens.k"];
		[all_keys addObject:@"resultado.k"];
		[all_keys addObject:@"tiptax.k"];

	}
	
	return all_keys;
}


@end
