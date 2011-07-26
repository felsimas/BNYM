//  Copyright 2011 Logic Diner. All rights reserved.

#import <UIKit/UIKit.h>
#import "GlobeViewController.h"
#import "globeAppDelegate.h"

@interface SettingsViewController : UIViewController {
   
    
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UILabel *titles;
    NSMutableData *responseData;
    UIScrollView *scrollview;
    NSInteger total;
    GlobeViewController *globeViewController;
    //UIViewController *rootViewController_globe;
    //MarkersForGlobeList *theMarkerList;
    NSMutableArray *myPresentationsTitle;
    NSMutableArray *myPresentationsStyle;
    NSInteger *currentPresentation;
}


@property (nonatomic, retain) NSMutableArray *myPresentationsTitle;
@property (nonatomic, retain) NSMutableArray *myPresentationsStyle;
//@property (nonatomic, retain) NSInteger *currentPresentation;

- (void) selectPresentation:(NSInteger*) presentationID;

- (IBAction)pushButton:(id)sender;
- (IBAction)selectPresentation1:(id)sender;
- (IBAction)selectPresentation2:(id)sender;
- (IBAction)selectPresentation3:(id)sender;
- (IBAction)selectPresentation4:(id)sender;
- (IBAction)selectPresentation5:(id)sender;
- (IBAction)selectPresentation6:(id)sender;
- (IBAction)selectPresentation7:(id)sender;
- (IBAction)selectPresentation8:(id)sender;
- (IBAction)selectPresentation9:(id)sender;
- (IBAction)selectPresentation10:(id)sender;
- (IBAction)selectPresentation11:(id)sender;
- (IBAction)selectPresentation12:(id)sender;
- (IBAction)selectPresentation13:(id)sender;
- (IBAction)selectPresentation14:(id)sender;
- (IBAction)selectPresentation15:(id)sender;
- (IBAction)selectPresentation16:(id)sender;
- (IBAction)selectPresentation17:(id)sender;
- (IBAction)selectPresentation18:(id)sender;
- (IBAction)selectPresentation19:(id)sender;
- (IBAction)selectPresentation20:(id)sender;

@property (nonatomic, retain) GlobeViewController *globeViewController;
@property (nonatomic, retain) IBOutlet UIScrollView *presentationGrid;




@end
