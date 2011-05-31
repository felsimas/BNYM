#import "PopupViewController.h"
#import "globeAppDelegate.h"
#import "CustomMoviePlayerViewController.h"

@implementation PopupViewController

@synthesize label;
@synthesize _delegate;
@synthesize movieView;
@synthesize moviePlayer;
#pragma mark -
#pragma mark View controller methods


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)viewDidLoad {
    NSLog(@"viewdidload");
   // self.player = [[MPMoviePlayerController alloc] init];
    //self.player.contentURL = [self movieURL];	 
    
 
    /*[self.movieView addSubview:player.view]; 
    //self.player.view.frame  = pageControlFrame;
    self.player.view.frame = self.movieView.bounds;
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    [self.player play]; */

    UIImage* image = [UIImage imageNamed:@"video_play.png"];
 //   UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );    
    button.frame = CGRectMake( 0, 0, image.size.width, image.size.height );    
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playVideoFullScreen:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.movieView addSubview: button]; 

    
}

- (void)loadMoviePlayer
{  
	// Play movie from the bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BNYM Hang Glider_720_h264" ofType:@"mov" inDirectory:nil];
    
	// Create custom movie player   
    moviePlayer = [[[CustomMoviePlayerViewController alloc] initWithPath:path] autorelease];
    
	// Show the movie player as modal
 	[self presentModalViewController:moviePlayer animated:YES];
    
	// Prep and play the movie
    [moviePlayer readyPlayer];  
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


- (IBAction)goToChapter{
   NSLog(@"touched");   


   globeAppDelegate *globeDelegate = (globeAppDelegate *)[[UIApplication sharedApplication] delegate];
    int i = 1;
 
   [globeDelegate setTabBarControllerAtIndex:i];
    
    [self._delegate closePopupWindow];

    //[globeDelegate release];

}
   

- (void)playVideoFullScreen:(id)sender{
    [self loadMoviePlayer];	
}


-(IBAction)goBackToGlobe{
    [self._delegate closePopupWindow];
}

- (void)setDelegate:(id)aDelegate{
    self._delegate = aDelegate; 
}


- (void)dealloc {
	self.label = nil;
    [movieView release];
    [super dealloc];
}


@end
