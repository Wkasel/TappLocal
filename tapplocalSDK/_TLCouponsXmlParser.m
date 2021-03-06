//
//  CouponsXmlParser.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 14/09/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLCouponsXmlParser.h"


@implementation _TLCouponsXmlParser


+(double)getDistanceFromStore:(_TLStore*) store: (float) lastLatitude: (float) lastLongitude
{
	int nRadius = 6371; // Earth's radius in Kilometers
    // Get the difference between our two points
    // then convert the difference into radians
    double nDLat = (store.latitude - lastLatitude) * (M_PI/180);
    double nDLon = (store.longitude - lastLongitude) * (M_PI/180);
    double nA = pow ( sin(nDLat/2), 2 ) + cos(lastLatitude) * cos(store.latitude) * pow ( sin(nDLon/2), 2 );
	
    double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
    double nD = nRadius * nC;
	
    return nD; // Return our calculated distance
}

+(void) xmlToCoupons:(NSMutableArray*)result :(NSString*) xml: (float) lastLatitude: (float) lastLongitude;
{
	//NSLog(@"%@",xml);
	
	//release the old coupons
	for (int i=[result count]-1;i>=0;i--)
		[[result objectAtIndex:i] release];
	
	//clean the array
	[result removeAllObjects];
	
	_TLXMLParser* parser = [[_TLXMLParser alloc]init];
	_TLTreeNode* node = [parser parseXMLfromString:xml];
	
	//varre os filhos
	for (int i=0; i<[[node children] count]; i++)
	{
		_TLTreeNode* cp = (_TLTreeNode*)[[node children] objectAtIndex:i];
		
		_TLCoupon* coupon = [[_TLCoupon alloc] init];
		
		for (int j=0; j<[[cp children] count]; j++)
		{
			_TLTreeNode* property = (_TLTreeNode*)[[cp children] objectAtIndex:j];
			
			if ([property.key isEqual:@"title"] && property.text != nil)
				coupon.title = property.text;
			else if ([property.key isEqual:@"text"] && property.text != nil)
				coupon.text = property.text;
			else if ([property.key isEqual:@"sex"] && property.text != nil)
				coupon.sex = property.text;
			else if ([property.key isEqual:@"logo"] && property.text != nil)
				coupon.logo = property.text;
			else if ([property.key isEqual:@"location"] && property.text != nil)
				coupon.location = property.text;
			else if ([property.key isEqual:@"dates"] && property.text != nil)
				coupon.dates = property.text;
			else if ([property.key isEqual:@"id"] && property.text != nil)
				coupon.idcoupon = [property.text intValue];
			else if ([property.key isEqual:@"ageto"] && property.text != nil)
				coupon.ageto = [property.text intValue];
			else if ([property.key isEqual:@"agefrom"] && property.text != nil)
				coupon.agefrom = [property.text intValue];
			else if ([property.key isEqual:@"merchant"])
			{
				_TLMerchant* merchant = [[_TLMerchant alloc] init];
				
				for (int k=0; k<[[property children] count]; k++)
				{
					_TLTreeNode* pmerchant = (_TLTreeNode*)[[property children] objectAtIndex:k];
										
					if ([pmerchant.key isEqual:@"name"] && pmerchant.text != nil)
						merchant.name = pmerchant.text;
					else if ([pmerchant.key isEqual:@"description"] && pmerchant.text != nil)
						merchant.description = pmerchant.text;
					else if ([pmerchant.key isEqual:@"logo"] && pmerchant.text != nil)
						merchant.logo = pmerchant.text;
					else if ([pmerchant.key isEqual:@"phone"] && pmerchant.text != nil)
						merchant.phone = pmerchant.text;
					else if ([pmerchant.key isEqual:@"site"] && pmerchant.text != nil)
						merchant.site = pmerchant.text;
					else if ([pmerchant.key isEqual:@"id"] && pmerchant.text != nil)
						merchant.idmerchant = [pmerchant.text intValue];
					else if ([pmerchant.key isEqual:@"representative"] && pmerchant.text != nil)
						merchant.idrepresentative = [pmerchant.text intValue];
				}
				
				[coupon setMerchant:merchant];
			}
			else if ([property.key isEqual:@"stores"])
			{
				for (int k=0; k<[[property children] count]; k++)
				{
					_TLTreeNode* pstore = (_TLTreeNode*)[[property children] objectAtIndex:k];
					
					_TLStore* store = [[_TLStore alloc] init];
					
					for (int l=0; l<[[pstore children] count]; l++)
					{
						_TLTreeNode* propstore = (_TLTreeNode*)[[pstore children] objectAtIndex:l];
					
						if ([propstore.key isEqual:@"name"] && propstore.text != nil)
							store.name = propstore.text;
						else if ([propstore.key isEqual:@"address"] && propstore.text != nil)
							store.address = propstore.text;
						else if ([propstore.key isEqual:@"phone"] && propstore.text != nil)
							store.phone = propstore.text;
						else if ([propstore.key isEqual:@"id"] && propstore.text != nil)
							store.idstore = [propstore.text intValue];
						else if ([propstore.key isEqual:@"latitude"] && propstore.text != nil)
							store.latitude = [propstore.text floatValue];						
						else if ([propstore.key isEqual:@"longitude"] && propstore.text != nil)
							store.longitude = [propstore.text floatValue];						
					}
					
					//store.distance = [self getDistanceFromStore:store :lastLatitude :lastLongitude];
						
					[coupon addStore:store];
				}
				
				//order stores by distance (DISABLED BECAUSE WE DECIDED TO ORDER THE COUPONS BY MONEY NOT DISTANCE)
				//[[coupon getStores] sortUsingSelector:@selector(compare:)];
			}
		}
			
		[result addObject:coupon];
	}
}

@end
