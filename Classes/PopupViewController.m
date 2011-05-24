#import "PopupViewController.h"
#import "globeAppDelegate.h"

@implementation PopupViewController

@synthesize label;
@synthesize _delegate;

#pragma mark -
#pragma mark View controller methods


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (IBAction)goToChapter{
   NSLog(@"touched");   
  [self._delegate closePopupWindow];

   globeAppDelegate *globeDelegate = (globeAppDelegate *)[[UIApplication sharedApplication] delegate];
   [globeDelegate setTabBarControllerAtIndex:1];
}
   
-(IBAction)goBackToGlobe{
    [self._delegate closePopupWindow];
}

- (void)setDelegate:(id)aDelegate{
    self._delegate = aDelegate; 
}


- (void)dealloc {
	self.label = nil;
    [super dealloc];
}


@end
