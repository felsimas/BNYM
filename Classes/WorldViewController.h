//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EAGLView.h"
#import "DDKCustomTabbar.h"
#import "ChaptersMenuController.h"

@interface WorldViewController : UIViewController <DDKTabBarDelegate, ChaptersMenuController,DismissPopDelegate>{
	UIActivityIndicatorView *activityIndicator;
	
	IBOutlet UISegmentedControl *countriesSegment;
	IBOutlet UISegmentedControl *glowSegment;
	IBOutlet UISegmentedControl *rotateSegment;
	
	IBOutlet EAGLView *theGlobe;
    
    ChaptersMenuController *_chaptersPicker;
    UIPopoverController *_chaptersPickerPopover;
}

@property (nonatomic, retain) ChaptersMenuController *chaptersPicker;
@property (nonatomic, retain) UIPopoverController *chaptersPickerPopover;

@end
