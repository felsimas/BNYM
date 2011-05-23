//  Copyright 2011 Logic Diner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorldViewController.h"
#import "GTabBar.h"
#import "DDKCustomTabbar.h"

@class WorldViewController;
@class SecondViewController;
@class ThirdViewController;
@class FourthViewController;

@interface globeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    GTabBar *customTab;

    WorldViewController *worldViewController;
    SecondViewController *secondViewController;
    ThirdViewController *thirdViewController;
    FourthViewController *fourthViewController;

	UIViewController *rootViewController_presentation;
	UIViewController *rootViewController_globe;
	UIViewController *rootViewController_feedback;
	UIViewController *rootViewController_custom;

	UINavigationController *navigationController;
}
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UIViewController *rootViewController_presentation;
@property (nonatomic, retain) UIViewController *rootViewController_globe;
@property (nonatomic, retain) UIViewController *rootViewController_feedback;
@property (nonatomic, retain) UIViewController *rootViewController_custom;

@property (nonatomic, retain) GTabBar *customTab;

@property (nonatomic, retain) SecondViewController *secondViewController;
@property (nonatomic, retain) ThirdViewController *thirdViewController;
@property (nonatomic, retain) FourthViewController *fourthViewController;
@property (nonatomic, retain) WorldViewController *worldViewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


@end

