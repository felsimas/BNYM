#import "PopupViewController.h"

@implementation PopupViewController

@synthesize label;


#pragma mark -
#pragma mark View controller methods


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)dealloc {
	self.label = nil;
    [super dealloc];
}


@end
