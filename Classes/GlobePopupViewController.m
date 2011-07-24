//  Copyright 2011 Logic Diner. All rights reserved.

#import "GlobePopupViewController.h"
#import "CustomMoviePlayerViewController.h"
#import "PdfViewController.h"
#import "Presentation.h"
#import "PointData.h"
#import "Slide.h"

@implementation GlobePopupViewController

@synthesize currentScreen;
@synthesize moviePlayer;
@synthesize movieView;
@synthesize player;
@synthesize pdfView;
@synthesize delegate;


@synthesize theList;



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
	currentScreen = 0;
	[UIView commitAnimations];	
    //[currentScreenView setImage:[UIImage imageNamed:@"popup1.png"]]; 
    [self nextScreen];
}

- (void)playVideoFullScreen:(id)sender{
    
    self.player = [[MPMoviePlayerController alloc] init];
    self.player.contentURL = [self movieURL];	 
    [self.movieView addSubview:player.view]; 
    self.player.view.frame = self.movieView.bounds;
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    [self.player play]; 
}

-(IBAction)popPdf{
	    
	//NSLog(@"pdf");
	/*if (self.pdfView == nil){
		NSLog(@"pdfView nulo");
        PdfViewController *view2 = [[PdfViewController alloc] initWithNibName:@"PdfView" bundle:[NSBundle mainBundle]];
        self.pdfView = view2;
	}*/
	//[self pushViewController:self.pdfView animated:YES];

	[self.delegate popPdf];
    
	
    /*PdfViewController *view2 = [[PdfViewController alloc] initWithNibName:@"PdfView" bundle:[NSBundle mainBundle]];
	//[self setView:[view2 view]];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:view2];
    [self presentModalViewController:navigationController animated:YES];
	
	//[navigationController release];
    [view2 release]; */
	
}	

-(NSURL *)movieURL
{
	int num = 1;
	NSString *itemUrl = @"BNY_Mellon_Hang_Glider";
	
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

    int count = [[Presentation currentPresentation].points count];
    NSLog(@"presentation points count %d", count);
    PointData *point = [[Presentation currentPresentation].points objectAtIndex:0];
    int numberofSlides = [point.slides count];
    if (currentScreen == numberofSlides){
        currentScreen = 0;
    }

    
  /*  if (currentScreen == 3){
        self.movieView.alpha = 1;
        [self addMovieView];
        self.movieView.alpha = 1;
    }else{
        self.movieView.alpha = 0;
        [self.player stop]; 
        for (UIView *view in self.movieView.subviews ){
            [view removeFromSuperview];
        }
    
    } */
    
    
    NSLog(@"number of slides %d", numberofSlides);
    
    NSArray *foo = [[[point.slides objectAtIndex:currentScreen] valueForKey:@"media"] componentsSeparatedByString: @"bnym/media"];
    NSString* imageStr1 = [foo objectAtIndex: 1];
    


    NSString *imageStr = [NSString stringWithFormat:@"http://ec2-174-129-66-92.compute-1.amazonaws.com/media/bnym/media%@", imageStr1];
    NSLog(@"imageStr %@", imageStr);

    NSURL *url = [NSURL URLWithString:imageStr];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; 
    
    //NSString *image = [NSString stringWithFormat:@"popup%i.png", currentScreen];
    [currentScreenView setImage:image]; 
    
    
    if (currentScreen == numberofSlides){
        currentScreen = 0;
    }else{
        currentScreen = currentScreen + 1;
    }
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
    [theList release];
    [moviePlayer release];
    [delegate release];
    [pdfView release];
    [player release];
    [movieView release];
    [super dealloc];
}


@end
