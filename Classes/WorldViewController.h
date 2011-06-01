//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EAGLView.h"
#import "DDKCustomTabbar.h"
#import "ChaptersMenuController.h"
#import "GlobePopupViewController.h"
#import "TwitterAuthController.h"

@interface WorldViewController : UIViewController <DDKTabBarDelegate, ChaptersMenuController,DismissPopDelegate, PopUpViewPDFDelegate>{
	UIActivityIndicatorView *activityIndicator;
	
	IBOutlet UISegmentedControl *countriesSegment;
	IBOutlet UISegmentedControl *glowSegment;
	IBOutlet UISegmentedControl *rotateSegment;
	
	IBOutlet EAGLView *theGlobe;
    GlobePopupViewController *controller;
    ChaptersMenuController *_chaptersPicker;
    UIPopoverController *_chaptersPickerPopover;
}

@property (nonatomic, retain) ChaptersMenuController *chaptersPicker;
@property (nonatomic, retain) UIPopoverController *chaptersPickerPopover;

@end
