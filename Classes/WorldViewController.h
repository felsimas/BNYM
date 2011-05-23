//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EAGLView.h"
#import "DDKCustomTabbar.h"
#import "ColorPickerController.h"

@interface WorldViewController : UIViewController <DDKTabBarDelegate, ColorPickerDelegate>{
	UIActivityIndicatorView *activityIndicator;
	
	IBOutlet UISegmentedControl *countriesSegment;
	IBOutlet UISegmentedControl *glowSegment;
	IBOutlet UISegmentedControl *rotateSegment;
	
	IBOutlet EAGLView *theGlobe;
    
    ColorPickerController *_colorPicker;
    UIPopoverController *_colorPickerPopover;
}

@property (nonatomic, retain) ColorPickerController *colorPicker;
@property (nonatomic, retain) UIPopoverController *colorPickerPopover;

@end
