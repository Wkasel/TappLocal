/*
 *  TappLocalScreenProtocol.h
 *  TappLocal
 *
 *  Created by Guilherme Carvalho on 22/08/10.
 *  Copyright 2010 Konkix. All rights reserved.
 *
 */

@protocol TappLocalScreenProtocol <NSObject>

@required

-(void) configure:(UIViewController*) parent;
-(void) removeFromSuperview;

@end
