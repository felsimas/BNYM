//  Copyright 2011 Logic Diner. All rights reserved.

#import "globeAppDelegate.h"
#import "WorldViewController.h"
#import "SecondViewController.h"
#import "Pool.h"
#import "Settings.h"
#import "FourthViewController.h"

#import "GTabBar.h"
#import "SecondViewController.h"
#import "ScrollViewWithPagingViewController.h"

@interface UITabBarController (private)
- (UITabBar *)tabBar;
@end

@implementation globeAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize worldViewController;
@synthesize secondViewController;
@synthesize tabBarController;
@synthesize rootViewController_presentation;
@synthesize rootViewController_globe;
@synthesize customTab;
@synthesize fourthViewController;
//@synthesize pool;
//@synthesize settings;
@synthesize rootViewController_custom;
@synthesize rootViewController_pool;
@synthesize rootViewController_settings;
@synthesize scrollViewController;
@synthesize rootViewController_scroll;

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

    
//	WorldViewController *rootViewController2 = [[[WorldViewController alloc] init] autorelease];
    rootViewController_globe = [[WorldViewController alloc] initWithNibName:@"World-iPad" bundle:nil];
    
    rootViewController_presentation = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    
    //rootViewController_pool = [[Pool alloc] initWithNibName:@"Pool" bundle:nil];

    //rootViewController_settings = [[Settings alloc] initWithNibName:@"Settings" bundle:nil];
    
    rootViewController_custom = [[FourthViewController alloc] initWithNibName:@"FourthViewController" bundle:nil];
    

    
    rootViewController_scroll = [[ScrollViewWithPagingViewController alloc]initWithNibName:@"ScrollViewWithPagingViewController" bundle:nil];

    
    
   worldViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_globe];
    
	[listOfViewControllers addObject:worldViewController];

   /* secondViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_presentation];
    [listOfViewControllers addObject:secondViewController]; */
    
    scrollViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_scroll];
    [listOfViewControllers addObject:scrollViewController];
    

    //pool = [[UINavigationController alloc] initWithRootViewController:rootViewController_pool];
    //[listOfViewControllers addObject:pool];

    //settings = [[UINavigationController alloc] initWithRootViewController:rootViewController_settings];
    //[listOfViewControllers addObject:settings];

    fourthViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController_custom];

	[listOfViewControllers addObject:fourthViewController];
    

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
    [scrollViewController release];
    [rootViewController_pool release];
    [rootViewController_settings release];
    [rootViewController_scroll release];
    [rootViewController_custom release];
    [rootViewController_globe release];
    [rootViewController_presentation release];
    [tabBarController release];
	[super dealloc];
}

@end
