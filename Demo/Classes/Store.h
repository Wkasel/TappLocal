//
//  Store.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Store : NSObject {
	NSString* title;
	NSString* phone;
	NSString* logo;
	NSString* address;
	NSString* mapname;
	NSString* followname;
	NSString* url;
}

@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* phone;
@property(nonatomic, retain) NSString* logo;
@property(nonatomic, retain) NSString* address;
@property(nonatomic, retain) NSString* mapname;
@property(nonatomic, retain) NSString* followname;
@property(nonatomic, retain) NSString* url;

@end
