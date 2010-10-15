//
//  XMLParser.m
//  LayerClient
//
//  Created by Meritia on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "_TLXMLParser.h"
#import "_TLByteUtils.h"
#import "_TLAQXMLParser.h"
#import "_TLAQXMLParserDelegate.h"

@implementation _TLXMLParser

@synthesize root;
@synthesize stack;

- (_TLTreeNode *)parseXMLfromString: (NSString *) string
{
	// Create a new clean stack
	self.stack = [[[NSMutableArray alloc] init] autorelease];
	
	// Initialize the root
	self.root = [[[_TLTreeNode alloc] init] autorelease];
	self.root.children = [[[NSMutableArray alloc] init] autorelease];
	[self.stack addObject:self.root];
	
	NSData* bytes = [_TLByteUtils getBytes:string];
	
	_TLAQXMLParser* parser2 = [[_TLAQXMLParser alloc]initWithData:bytes];
    [parser2 setDelegate:self];	
	
	[parser2 parse];	
	
	// pop down to real root
	return [self.root.children lastObject];
}

- (void) dealloc
{
	if (self.stack) [self.stack release];
	if (self.root) [self.root release];
	[super dealloc];
}

- (void)parser:(_TLAQXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
	_TLTreeNode *leaf = [[[_TLTreeNode alloc] init] autorelease];
	
	if (((_TLTreeNode*)[stack lastObject]).children == nil)
	{
		[((_TLTreeNode*)[stack lastObject]).children = [[NSMutableArray alloc] init] autorelease];
	}
	
	[((_TLTreeNode*)[stack lastObject]).children addObject:leaf];
	[self.stack addObject:leaf];
	
	leaf.key = elementName;
	leaf.attributes = attributeDict;
}

- (void)parser:(_TLAQXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
	[self.stack removeLastObject];
}

- (void)parser:(_TLAQXMLParser *)parser foundCharacters:(NSString *)string
{
	if ([self.stack count] > 0)
	{
		string = [string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
		
		if (![string isEqualToString:@""])
		{
			_TLTreeNode *leaf = [self.stack objectAtIndex:[self.stack count]-1];
		
			if (leaf.text == nil)
				leaf.text = [[NSMutableString alloc]initWithString:string];
			else
				[leaf.text appendString:string];
		}
	}
	
}


@end
