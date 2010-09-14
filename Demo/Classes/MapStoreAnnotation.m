//
//  MapStoreAnnotation.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 19/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "MapStoreAnnotation.h"


@implementation MapStoreAnnotation
@synthesize coordinate;

- (NSString *)subtitle{
	return mSubtitle;
}
- (NSString *)title{
	return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString*)t subtitle:(NSString*)s
{
	coordinate=c;
	mTitle = t;
	mSubtitle = s;
	return self;
}
@end
