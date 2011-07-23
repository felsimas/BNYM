//  Copyright 2011 Logic Diner. All rights reserved.

#import "PollViewController.h"
#import "CustomTabBarItem.h"
#import "globeAppDelegate.h"

@implementation PollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        CustomTabBarItem *tabItem = [[CustomTabBarItem alloc]
                                     initWithTitle:@"Polls" image:nil tag:0];
        
        tabItem.customHighlightedImage=[UIImage imageNamed:@"tabIconSelected.png"];
        tabItem.customStdImage=[UIImage imageNamed:@"tabIcon.png"];       
        
        self.tabBarItem=tabItem;
        [tabItem release]; 
        tabItem=nil;   
        
    }
    return self;
}


- (id) init
{   
    if(self = [super init])
    {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
 //   CustomTabBarItem *tabItem = [[CustomTabBarItem alloc]
  //                               initWithTitle:@"Pool" image:nil tag:0];
    
 //   tabItem.customHighlightedImage=[UIImage imageNamed:@"tabIconSelected.png"];
 //   tabItem.customStdImage=[UIImage imageNamed:@"tabIcon.png"];       
    
 //   self.tabBarItem=tabItem;
 //   [tabItem release]; 
 //   tabItem=nil;    
    
    
}

- (IBAction)touchedGlobe:(id)sender{
    NSLog(@"touched");   
    globeAppDelegate *globeDelegate = (globeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [globeDelegate setTabBarControllerAtIndex:0];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}



- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
