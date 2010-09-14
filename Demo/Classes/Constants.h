//
//  Constants.h
//  Hello3
//
//  Created by Guilherme Carvalho on 19/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Constants : NSObject {

}

extern int const KEY_NOT_CAPTURED;
extern int const KEY_CAPTURED;
extern int const KEY_OPEN_INPUT_FORM;

extern int const maxUsefullBytesInPacket;
extern int const packetHeaderLenght;
extern int const lengthPack;
extern int idPack;
extern int const MAX_CLIENT_REQUEST_HANDLER;

extern int const FONT_SIZE_SMALL;
extern int const FONT_SIZE_MEDIUM;
extern int const FONT_SIZE_LARGE;

extern NSString* const COMMAND_ENABLE_CONNECTION;
extern NSString* const COMMAND_CLOSE_APPLICATION;
extern NSString* const COMMAND_CLEAN_RMS;
extern NSString* const COMMAND_RESET_APPLICATION;
extern NSString* const COMMAND_OPEN_PAGE;

extern NSString* const COMMAND_SELECT_DATASOURCE;
extern NSString* const COMMAND_CLEAN_DATASOURCE;

extern NSString* const COMMAND_ADD_RECORD_DATASOURCE;
extern NSString* const COMMAND_DELETE_RECORD_DATASOURCE;
extern NSString* const COMMAND_MODIFY_RECORD_DATASOURCE;
extern NSString* const COMMAND_SELECT_RECORD_DATASOURCE;
extern NSString* const COMMAND_SHOW_ERROR;
extern NSString* const COMMAND_SHOW_HELP;
extern NSString* const COMMAND_SHOW_LOADING;
extern NSString* const COMMAND_SHOW_MESSAGE;
extern NSString* const COMMAND_SHOW_CONFIRMATION;
extern NSString* const COMMAND_SEND_EMAIL;
extern NSString* const COMMAND_OPEN_BROWSER;

extern NSString* const RECORDSTORE_USER_ID;
extern NSString* const RECORDSTORE_USER_NAME;
extern NSString* const RECORDSTORE_PASSWORD;
extern NSString* const RECORDSTORE_APPLICATION_ID;
extern NSString* const RECORDSTORE_SERVER_IP;
extern NSString* const RECORDSTORE_SERVER_PORT;
extern NSString* const RECORDSTORE_FIRST_PAGE;
extern NSString* const RECORDSTORE_FONT_SIZE;
extern NSString* const RECORDSTORE_CACHE_MANAGER;
extern NSString* const RECORDSTORE_LOADING_BG;
extern NSString* const RECORDSTORE_LOADING_FG;
extern NSString* const RECORDSTORE_LOADING_STRING;
extern NSString* const RECORDSTORE_CANCEL_STRING;
extern NSString* const RECORDSTORE_OK_STRING;
extern NSString* const RECORDSTORE_LANGUAGE;

extern NSString* const CACHE_SEPARATOR;

extern NSString* const DEGRADE_KIND_VERTICAL;
extern NSString* const DEGRADE_KIND_HORIZONTAL;
extern NSString* const DEGRADE_KIND_DIAGONAL;
extern NSString* const DEGRADE_KIND_HORIZONTAL_MEIO;
extern NSString* const DEGRADE_KIND_DIAGONAL_INVERTIDA;

+(NSMutableArray*) getAUTOLOADING_RECORDSTORE_KEYS;
+(NSMutableArray*) getALL_RECORDSTORE_KEYS;

@end
