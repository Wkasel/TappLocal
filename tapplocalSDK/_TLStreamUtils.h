//
//  StreamUtils.h
//  Hello3
//
//  Created by Guilherme Carvalho on 20/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface _TLStreamUtils : NSObject {

}

+(NSMutableData*) readFully:(NSInputStream*) stream: (int) maxSize;

@end
