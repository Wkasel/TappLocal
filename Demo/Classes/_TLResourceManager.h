//
//  ResourceManager.h
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface _TLResourceManager : NSObject {

}

+(NSString*) getResourceTextFile:(NSString*) filename;
+(NSMutableData*) getResourceBinaryFile:(NSString*) filename;

@end
