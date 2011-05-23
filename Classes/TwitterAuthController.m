//  Copyright 2011 Logic Diner. All rights reserved.

#import "TwitterAuthController.h"


@implementation TwitterAuthController

//@synthesize webView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	backgroundView.alpha = 0;
	//webView.alpha = 0;
	closeButton.alpha = 0;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:.5];
	
	backgroundView.alpha = 1;
	
	[UIView setAnimationDelay:.25];
	//webView.alpha = 1;
	closeButton.alpha = 1;
	
	[UIView commitAnimations];	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark -
#pragma mark UIWebViewDelegate Protocol

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//	return YES;
//}


-(void) dismiss
{
	//webView.alpha = 0;	
	closeButton.alpha = 0;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:.25];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(fadeOutFinished)];

	backgroundView.alpha = 0;
	
	[UIView commitAnimations];	
	
}

-(void) fadeOutFinished
{
	
	[self.view removeFromSuperview];
}

	
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
