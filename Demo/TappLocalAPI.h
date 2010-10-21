//
//  TappLocalAPI.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 07/10/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TappLocalAPI : NSObject {
	
	BOOL running;
}

@property(readonly,assign) BOOL running;

-(TappLocalAPI*) initWithViewController:(UIViewController*)v:(NSString*)code;
-(void)start;
-(void)stop;
-(void)setRefreshTimeNewAds:(int) seconds;
-(void)setSimulationMode:(BOOL) s;

@end
