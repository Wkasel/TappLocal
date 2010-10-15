//
//  SingleMapView.m
//  TappLocal
//
//  Created by Guilherme Carvalho on 19/08/10.
//  Copyright 2010 Konkix. All rights reserved.
//

#import "_TLSingleMapView.h"
#import "_TL.h"

@implementation _TLSingleMapView

-(void) configure:(id) parent
{
	tl = parent;
	
	if (!isBuilt)
	{
		isBuilt = true;
		
		mother = [[_TLTappLocalView alloc]init];
		mother.frame = CGRectMake(0, 0, 320, 480);
		mother.backgroundColor = [UIColor clearColor];
		
		wv = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
		[mother addSubview:wv];
		
		plate  = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		plate.backgroundColor = [UIColor blackColor];
		[mother addSubview:plate];	
		
		top = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, 320, 43)];
		top.barStyle = UIBarStyleBlackTranslucent;
		[mother addSubview:top];	
		
		UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
		UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"Stores"];
		item.rightBarButtonItem = rightButton;
		[top pushNavigationItem:item animated:NO];
		
		UIButton* button = [UIButton buttonWithType:101];
		UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 35, 20)];
		label.textColor = [_TLColorUtils colorFromRGB:@"FFFFFF"];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.text = @"Back";
		label.font = [UIFont fontWithName:@"Arial-BoldMT" size:13.0f];
		[button addSubview:label];
		[button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
		button.frame = CGRectMake(5, 7, 50, 30);
		[mother addSubview:button];
	}
	
	_TLStore* store = [[[(_TL*)tl getCurrentCoupon] getStores] objectAtIndex:0];
	
	NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?f=d&source=s_d&saddr=%f+%f&daddr=%f+%f&dirflg=w",[(_TL*)tl lastLatitude],[(_TL*)tl lastLongitude],store.latitude, store.longitude  ];
	NSURLRequest* requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	[wv loadRequest:requestObj];
	
	[((_TL*)tl).vc.view addSubview:mother];
}

-(void) merchantClick
{
	[(_TL*)tl setScreen:@"SCREEN_STORE":false];
}

-(void) backClick
{
	[mother removeFromSuperview];
}

-(void) closeClick
{
	[(_TL*)tl sendLog:TL_ACTION_CLOSE:nil];
	[(_TL*)tl closeCoupons];
}

-(void) removeFromSuperview
{
	[mother removeFromSuperview];
}

-(void) dealloc
{
	[mother release];
	[wv release];
	[plate release];
	[top release];
	[close release];
	
	[super dealloc];
}

@end
