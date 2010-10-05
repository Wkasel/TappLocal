//
//  Datasource.h
//  ContaDividida
//
//  Created by Guilherme Carvalho on 01/12/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _TLDatasource : NSObject {
	NSString* name;
	NSMutableArray* captions;
	NSMutableArray* data;
}

-(_TLDatasource*) initWithString:(NSString*) contents;
-(void) setName:(NSString*)newName;
-(NSString*) getName;
-(NSMutableArray*) getCaptions;
-(NSMutableArray*) getData;
-(NSString*)toString;
-(void)updateIndex:(int)index:(NSArray*) values;
-(void)deleteIndex:(int)index;
-(void)deleteAll;
-(void)addIndex:(NSArray*) values;
-(NSArray*)getIndex:(int) values;

@end
