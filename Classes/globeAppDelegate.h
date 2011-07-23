//  Copyright 2011 Logic Diner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorldViewController.h"
#import "GTabBar.h"
#import "DDKCustomTabbar.h"

@class WorldViewController;
@class SecondViewController;
@class Pool;
@class Settings;
@class FourthViewController;
@class ScrollViewWithPagingViewController;

@interface globeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    GTabBar *customTab;

    WorldViewController *worldViewController;
    SecondViewController *secondViewController;
    Pool *pool;
    Settings *settings;
    FourthViewController *fourthViewController;
    ScrollViewWithPagingViewController *scrollViewController;

	UIViewController *rootViewController_presentation;
	UIViewController *rootViewController_globe;
	UIViewController *rootViewController_pool;
	UIViewController *rootViewController_settings;
	UIViewController *rootViewController_custom;
	UIViewController *rootViewController_scroll;

	UINavigationController *navigationController;
}
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UIViewController *rootViewController_scroll;
@property (nonatomic, retain) UIViewController *rootViewController_presentation;
@property (nonatomic, retain) UIViewController *rootViewController_globe;
@property (nonatomic, retain) UIViewController *rootViewController_pool;
@property (nonatomic, retain) UIViewController *rootViewController_settings;
@property (nonatomic, retain) UIViewController *rootViewController_custom;
@property (nonatomic, retain) ScrollViewWithPagingViewController *scrollViewController;
@property (nonatomic, retain) GTabBar *customTab;
@property (nonatomic, retain) SecondViewController *secondViewController;
@property (nonatomic, retain) Settings *settings;
@property (nonatomic, retain) Pool *pool;
@property (nonatomic, retain) FourthViewController *fourthViewController;
@property (nonatomic, retain) WorldViewController *worldViewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


@end

