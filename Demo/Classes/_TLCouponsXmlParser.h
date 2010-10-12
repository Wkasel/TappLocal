//
//  CouponsXmlParser.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 14/09/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"
#import "_TLCoupon.h"
#import "_TLMerchant.h"
#import "_TLStore.h"
#import "XMLParser.h"

@interface _TLCouponsXmlParser : NSObject {

}

+(void) xmlToCoupons:(NSMutableArray*)arr :(NSString*) xml: (float) lastLatitude: (float) lastLongitude;

@end
