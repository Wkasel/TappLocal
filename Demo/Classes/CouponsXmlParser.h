//
//  CouponsXmlParser.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 14/09/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"
#import "Coupon.h"
#import "Merchant.h"
#import "Store.h"
#import "XMLParser.h"

@interface CouponsXmlParser : NSObject {

}

+(NSMutableArray*) xmlToCoupons:(NSString*) xml;

@end
