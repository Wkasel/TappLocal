//
//  TreeNode.m
//  LayerClient
//
//  Created by Meritia on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "_TLTreeNode.h"


@implementation _TLTreeNode

@synthesize children;
@synthesize key;
@synthesize text;
@synthesize attributes;

// Return the first child that matches the key
- (_TLTreeNode*) objectForKey: (NSString *) aKey
{
	for (_TLTreeNode* node in self.children) 
		if ([[node key] isEqualToString: aKey]) 
			return node;
	return NULL;
}

- (void) dealloc
{
	if (self.key) 
		[self.key release];
	if (self.children) 
		[self.children release];
	
	[super dealloc];
}

@end