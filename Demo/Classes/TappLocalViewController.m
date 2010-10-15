//
//  GameClockViewController.m
//  GameClock
//
//  Created by Guilherme Carvalho on 16/07/10.
//  Copyright Konkix 2010. All rights reserved.
//

#import "TappLocalViewController.h"


@implementation TappLocalViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	hView = [[HomeView alloc] init];
	
	[hView configure: self];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
