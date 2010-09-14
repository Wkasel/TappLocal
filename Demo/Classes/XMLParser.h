//
//  XMLParser.h
//  LayerClient
//
//  Created by Meritia on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"
#import "AQXMLParserDelegate.h"
#import "TextUtils.h"

@interface XMLParser : NSObject<AQXMLParserDelegate> {
	NSMutableArray *stack;
	TreeNode *root;
	bool isOpen;
}

- (TreeNode *)parseXMLfromString: (NSString *) string;

@property (nonatomic, retain) NSMutableArray *stack;
@property (nonatomic, retain) TreeNode *root;

@end