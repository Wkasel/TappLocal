//
//  TextUtils.h
//  Hello3
//
//  Created by Guilherme Carvalho on 20/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface _TLTextUtils : NSObject {

}

+(NSString*) cgfloatToString: (CGFloat) floatNumber;
+(int) indexOf:(NSString*) base: (NSString*) searched;
+(NSString*) insertParameters:(NSString*) url: (NSArray*) parameters;
+(NSString*) appendParameterInUrl:(NSString*) url: (NSString*) parameter;
+(NSString*) replaceText:(NSString*) base: (NSString*) token: (NSString*) replaceString;

@end
