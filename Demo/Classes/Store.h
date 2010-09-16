//
//  Store.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Store : NSObject {
	int idstore;
	float latitude;
	float longitude;
	NSString* name;
	NSString* phone;
	NSString* address;
}

@property(nonatomic, assign) int idstore;
@property(nonatomic, assign) float latitude;
@property(nonatomic, assign) float longitude;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* phone;
@property(nonatomic, retain) NSString* address;



@end
