//
//  Coupon.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 22/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Coupon : NSObject {

	NSString* title;
	NSString* text;
	NSString* storename;
	float latitude;
	float longitude;
}

@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* text;
@property(nonatomic, retain) NSString* storename;
@property(nonatomic, assign) float longitude;
@property(nonatomic, assign) float latitude;

@end
