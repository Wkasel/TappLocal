//
//  CacheManager.h
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface _TLCacheManager : NSObject {
@private 
	NSMutableArray* indexUrlVector;
	NSMutableArray* errorImageUrls;
}

+(_TLCacheManager *) instance;
+(_TLCacheManager *) remakeInstance;
-(NSString*) getNewRandomKey;
-(void) persist;
-(void) addErrorImageUrl:(NSString*) url;
-(void) addItem:(NSString*) url: (NSMutableData*) data;
-(void) deleteItem:(NSString*) url;
-(NSMutableData*) getItem:(NSString*) url;

@end
