//
//  XMLParser.h
//  LayerClient
//
//  Created by Meritia on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_TLTreeNode.h"
#import "_TLAQXMLParserDelegate.h"
#import "_TLTextUtils.h"

@interface _TLXMLParser : NSObject<_TLAQXMLParserDelegate> {
	NSMutableArray *stack;
	_TLTreeNode *root;
	bool isOpen;
}

- (_TLTreeNode *)parseXMLfromString: (NSString *) string;

@property (nonatomic, retain) NSMutableArray *stack;
@property (nonatomic, retain) _TLTreeNode *root;

@end