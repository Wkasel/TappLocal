//
//  TreeNode.h
//  LayerClient
//
//  Created by Meritia on 22/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface _TLTreeNode : NSObject {
	NSMutableArray *children;
	NSString *key;
	NSMutableString* text;
	NSDictionary *attributes;
}
@property (nonatomic, retain) NSMutableArray *children;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSMutableString *text;
@property (nonatomic, retain) NSDictionary *attributes;

-(_TLTreeNode*) objectForKey: (NSString*) aKey;

@end
