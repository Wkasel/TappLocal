//
//  Test.h
//  TappLocal
//
//  Created by Guilherme Carvalho on 26/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Test : NSObject {
		int number1;
		int number2;
	}
	
@property(nonatomic, assign) int number1;
@property(nonatomic, assign) int number2;
	
-(int)multiply;
	
	
@end
