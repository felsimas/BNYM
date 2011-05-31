//  Copyright 2011 Logic Diner. All rights reserved.

#import "GlobePopupViewController.h"
#import "CustomMoviePlayerViewController.h"


@implementation GlobePopupViewController

@synthesize currentScreen;
@synthesize moviePlayer;
@synthesize movieView;
@synthesize player;

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
    self.movieView.alpha = 0;

    [self addMovieView];
    
    
	[UIView setAnimationDelay:.25];
	//webView.alpha = 1;
	closeButton.alpha = 1;
	currentScreen = 1;
	[UIView commitAnimations];	
    [currentScreenView setImage:[UIImage imageNamed:@"popup1.png"]]; 

}

- (void)playVideoFullScreen:(id)sender{
    
    self.player = [[MPMoviePlayerController alloc] init];
    self.player.contentURL = [self movieURL];	 
    [self.movieView addSubview:player.view]; 
    self.player.view.frame = self.movieView.bounds;
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    [self.player play]; 
}


-(NSURL *)movieURL
{
	int num = 1;
	NSString *itemUrl = @"BNYM Hang Glider_720_h264";
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:itemUrl ofType:@"mov"];
    
	if (moviePath) {
		return [NSURL fileURLWithPath:moviePath];
	} else {
		return nil;
	}
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


-(void)dismiss
{
	//webView.alpha = 0;	
	closeButton.alpha = 0;
    [self.player stop]; 
    for (UIView *view in self.movieView.subviews ){
        [view removeFromSuperview];
    }
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:.25];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(fadeOutFinished)];
    
	backgroundView.alpha = 0;
	self.movieView.alpha = 0;
	[UIView commitAnimations];	
	
}

-(void) fadeOutFinished
{
	
	[self.view removeFromSuperview];
}

-(IBAction) nextScreen{
    if (currentScreen == 3){
        self.movieView.alpha = 1;
        [self addMovieView];
        self.movieView.alpha = 1;
    }else{
        self.movieView.alpha = 0;
        [self.player stop]; 
        for (UIView *view in self.movieView.subviews ){
            [view removeFromSuperview];
        }
    
    }
    
    if (currentScreen == 4){
        currentScreen = 1;
    }else{
        currentScreen = currentScreen + 1;
    }


    
    NSString *image = [NSString stringWithFormat:@"popup%i.png", currentScreen];
    [currentScreenView setImage:[UIImage imageNamed:image]]; 
}

- (void)addMovieView{
    NSLog(@"addmovieview");
    UIImage* image = [UIImage imageNamed:@"videoThumb.png"];
    //   UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );    
    button.frame = CGRectMake( 0, 0, image.size.width, image.size.height );    
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playVideoFullScreen:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.movieView addSubview: button]; 
    
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
    [moviePlayer release];
    [player release];
    [movieView release];
    [super dealloc];
}


@end
