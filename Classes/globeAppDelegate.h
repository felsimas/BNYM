//  Copyright 2011 Logic Diner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobeViewController.h"
#import "GTabBar.h"
#import "DDKCustomTabbar.h"

@class GlobeViewController;
@class OrbViewController;
@class PresentationViewController;
@class PollViewController;
@class SettingsViewController;
@class BlankViewController;


@interface globeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    GTabBar *customTab;

    GlobeViewController *globeViewController;
    OrbViewController *orbViewController;
    PresentationViewController *presentationViewController;
    PollViewController *pollViewController;
    SettingsViewController *settingsViewController;
	BlankViewController *blankViewController;

    UIViewController *rootViewController_globe;
    UIViewController *rootViewController_orb;
	UIViewController *rootViewController_presentation;
	UIViewController *rootViewController_poll;
	UIViewController *rootViewController_settings;
	UIViewController *rootViewController_blank;

	UINavigationController *navigationController;
}

@property (nonatomic, retain) UITabBarController *tabBarController;

@property (nonatomic, retain) UIViewController *rootViewController_globe;
@property (nonatomic, retain) UIViewController *rootViewController_orb;
@property (nonatomic, retain) UIViewController *rootViewController_presentation;
@property (nonatomic, retain) UIViewController *rootViewController_poll;
@property (nonatomic, retain) UIViewController *rootViewController_settings;
@property (nonatomic, retain) UIViewController *rootViewController_blank;

@property (nonatomic, retain) GlobeViewController *globeViewController;
@property (nonatomic, retain) OrbViewController *orbViewController;
@property (nonatomic, retain) PresentationViewController *presentationViewController;
@property (nonatomic, retain) PollViewController *pollViewController;
@property (nonatomic, retain) SettingsViewController *settingsViewController;
@property (nonatomic, retain) BlankViewController *blankViewController;


@property (nonatomic, retain) GTabBar *customTab;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


@end

