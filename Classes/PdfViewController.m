//
//  PdfViewController.m
//  WebViewTutorial
//
//  Created by iPhone SDK Articles on 8/19/08.
//  Copyright 2008 www.iPhoneSDKArticles.com. All rights reserved.
//

#import "PdfViewController.h"


@implementation PdfViewController

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad. */
- (void)viewDidLoad {
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle: @"Back" 
																							  style: UIBarButtonItemStyleBordered 
																							 target: self 
																							 action: @selector(backButtonTouched:)] autorelease];
	
	NSLog(@"load do webview");
	
	
	
	NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"bnym" ofType:@"pdf"];
	
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webView loadRequest:requestObj];
	
	
	
	
	//NSString *urlAddress = @"http://www.bnymellon.com/foresight/readcounter.cfm?id=tl187&lb=wm&WT.cg_n=ForeSight&WT.cg_s=ArticlesHome";
	
	//Create a URL object.
	//NSURL *url = [NSURL URLWithString:urlAddress];
	//URL Requst Object
	//NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	//[webView loadRequest:requestObj];
}

- (void) backButtonTouched:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[webView release];
	[super dealloc];
}


@end
