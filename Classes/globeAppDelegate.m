//  Copyright 2011 Logic Diner. All rights reserved.

#import "globeAppDelegate.h"
#import "GTabBar.h"

#import "GlobeViewController.h"
#import "OrbViewController.h"
#import "PresentationViewController.h"
#import "PollViewController.h"
#import "SettingsViewController.h"
#import "BlankViewController.h"

@interface UITabBarController (private)
- (UITabBar *)tabBar;
@end

@implementation globeAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize tabBarController;
@synthesize customTab;

@synthesize globeViewController;
@synthesize orbViewController;
@synthesize presentationViewController;
@synthesize pollViewController;
@synthesize settingsViewController;
@synthesize blankViewController;

@synthesize rootViewController_globe;
@synthesize rootViewController_orb;
@synthesize rootViewController_presentation;
@synthesize rootViewController_poll;
@synthesize rootViewController_settings;
@synthesize rootViewController_blank;


- (void)applicationDidFinishLaunching:(UIApplication *)application {

    NSMutableArray *listOfViewControllers = [[[NSMutableArray alloc]init]autorelease];
	
    tabBarController = [[UITabBarController alloc] init];
	
    CGRect frame = CGRectMake(0, 0, 1024, 49);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"TBBackground.png"];
    UIColor *color = [[UIColor alloc] initWithPatternImage:tabBarBackgroundImage];
    
    [view setBackgroundColor:color];
    [color release];
    [[tabBarController tabBar]insertSubview:view atIndex:0];
    [view release];

    rootViewController_globe = [[GlobeViewController alloc] initWithNibName:@"World-iPad" bundle:nil]; 
	rootViewController_orb = [[OrbViewController alloc]initWithNibName:@"OrbViewController" bundle:nil];
    rootViewController_presentation  = [[PresentationViewController alloc] initWithNibName:@"PresentationViewController" bundle:nil];
    rootViewController_poll = [[PollViewController alloc] initWithNibName:@"PollViewController" bundle:nil];
    rootViewController_settings = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];    
    rootViewController_blank = [[BlankViewController alloc] initWithNibName:@"BlankViewController" bundle:nil];  
    

    globeViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_globe];
	[listOfViewControllers addObject:globeViewController];
	
	orbViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_orb];
    [listOfViewControllers addObject:orbViewController];

    presentationViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_presentation];
    [listOfViewControllers addObject:presentationViewController]; 
    
    pollViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_poll];
    [listOfViewControllers addObject:pollViewController];  

	blankViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_blank];
	[listOfViewControllers addObject:blankViewController];

	settingsViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_settings];
    [listOfViewControllers addObject:settingsViewController];

    
    

	[self.tabBarController setViewControllers:listOfViewControllers
                                     animated:YES];
    application.statusBarOrientation = UIInterfaceOrientationLandscapeLeft;

    [window addSubview:tabBarController.view];

}


- (void)setTabBarControllerAtIndex: (int) aTab{
    NSLog( @"setTabBarControllerAtIndex");
    [[self tabBarController] setSelectedIndex:aTab];
}




- (void)dealloc {
	[window release];
    [tabBarController release];
    
    [globeViewController release];
    [orbViewController release];
    [presentationViewController release];
    [pollViewController release];
    [settingsViewController release];
    [blankViewController release];
    
    [rootViewController_globe release];
    [rootViewController_orb release];
    [rootViewController_presentation release];
    [rootViewController_poll release];
    [rootViewController_settings release];
    [rootViewController_blank release];
    
	[super dealloc];
}

@end
