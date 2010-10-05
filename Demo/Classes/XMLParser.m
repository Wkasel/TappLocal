//
//  XMLParser.m
//  LayerClient
//
//  Created by Meritia on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "_TLByteUtils.h"
#import "AQXMLParser.h"
#import "AQXMLParserDelegate.h"

@implementation XMLParser

@synthesize root;
@synthesize stack;

- (TreeNode *)parseXMLfromString: (NSString *) string
{
	// Create a new clean stack
	self.stack = [[[NSMutableArray alloc] init] autorelease];
	
	// Initialize the root
	self.root = [[[TreeNode alloc] init] autorelease];
	self.root.children = [[[NSMutableArray alloc] init] autorelease];
	[self.stack addObject:self.root];
	
	NSData* bytes = [_TLByteUtils getBytes:string];
	
	AQXMLParser* parser2 = [[AQXMLParser alloc]initWithData:bytes];
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

- (void)parser:(AQXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
	TreeNode *leaf = [[[TreeNode alloc] init] autorelease];
	
	if (((TreeNode*)[stack lastObject]).children == nil)
	{
		[((TreeNode*)[stack lastObject]).children = [[NSMutableArray alloc] init] autorelease];
	}
	
	[((TreeNode*)[stack lastObject]).children addObject:leaf];
	[self.stack addObject:leaf];
	
	leaf.key = elementName;
	leaf.attributes = attributeDict;
}

- (void)parser:(AQXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
	[self.stack removeLastObject];
}

- (void)parser:(AQXMLParser *)parser foundCharacters:(NSString *)string
{
	if ([self.stack count] > 0)
	{
		string = [string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
		
		if (![string isEqualToString:@""])
		{
			TreeNode *leaf = [self.stack objectAtIndex:[self.stack count]-1];
		
			if (leaf.text == nil)
				leaf.text = [[NSMutableString alloc]initWithString:string];
			else
				[leaf.text appendString:string];
		}
	}
	
}


@end
