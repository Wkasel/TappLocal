//
//  TextUtils.h
//  Hello3
//
//  Created by Guilherme Carvalho on 20/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface _TLTextUtils : NSObject {

}

+(NSString*) cgfloatToString: (CGFloat) floatNumber;
+(NSMutableString*) decodeBase64String:(NSString*) string;
+(NSMutableString*) encodeBase64String:(NSString*) string;
+(int) indexOf:(NSString*) base: (NSString*) searched;
+(NSString*) insertParameters:(NSString*) url: (NSArray*) parameters;
+(NSString*) appendParameterInUrl:(NSString*) url: (NSString*) parameter;
+(NSString*) replaceText:(NSString*) base: (NSString*) token: (NSString*) replaceString;

@end
