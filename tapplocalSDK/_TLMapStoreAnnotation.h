//
//  MapStoreAnnotation.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 19/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface _TLMapStoreAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString* mTitle;
	NSString* mSubtitle;
	int indexCoupon;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite) int indexCoupon;

-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate title:(NSString*)t subtitle:(NSString*)s;
- (NSString *)subtitle;
- (NSString *)title;

@end
