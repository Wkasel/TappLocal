//
//  RMSTracker.h
//  Hello3
//
//  Created by Guilherme Carvalho on 26/10/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RMSTracker : NSObject {

}

+(NSMutableData*) loadSafe:(NSString*) name;
+(NSString*) loadSafeString:(NSString*) name;
+(NSMutableData*) load:(NSString*) name;
+(void) saveString:(NSString*) name: (NSString*) data;
+(void) saveArray:(NSString*) name: (NSMutableArray*) data;
+(void) saveBytes:(NSString*) name: (NSMutableData*) data;
+(void) clearRMS;
+(void) deleteRecordstore:(NSString*) recordstoreName;
+(Boolean) existRecordstore:(NSString*) name;
+(NSString*) getFullFileName:(NSString*) name;


@end
