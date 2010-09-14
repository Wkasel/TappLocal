//
//  ColorUtils.h
//  Hello3
//
//  Created by Guilherme Carvalho on 29/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ColorUtils : NSObject {

}

+(UIColor*) colorFromRGB:(NSString*) value;
+(UIColor*) randomColor;

@end
