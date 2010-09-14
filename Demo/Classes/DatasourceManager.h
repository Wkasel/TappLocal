//
//  DatasourceManager.h
//  ContaDividida
//
//  Created by Guilherme Carvalho on 01/12/09.
//  Copyright 2009 Konkix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Datasource.h"

@interface DatasourceManager : NSObject {
	
}

+(Datasource*) getDatasource:(NSString*) name;
+(void) saveDatasource:(Datasource*) datasource;

@end
