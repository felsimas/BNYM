//
//  MapViewController.h
//  TravelGames
//
//  Created by Steven on 7/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"



@interface MapViewController : UIViewController <MKMapViewDelegate>{
	MKMapView *mapView;
	UIButton *backButton;
	UISegmentedControl *theSegmentedControl;
	
	MyAnnotation *annotation;
	
	int parkingMapSelection;
	
	float lastLat;
	float lastLong;
	float destinationLat;
	float destinationLong;
	NSTimer *updateMyLocationTimer;
	
	MKPlacemark *thePlaceMark;
	CLLocation *theLocation;
}

-(id)initWithPlaceMark:(MKPlacemark *)aPlace loc:(CLLocation*)aLocation;

@property (retain) 	IBOutlet MKMapView *mapView;
@property (retain) 	IBOutlet UIButton *backButton;
@property (retain)  IBOutlet UISegmentedControl *theSegmentedControl;
@property (assign)  int parkingMapSelection;
@property (assign)  float destinationLat;
@property (assign)  float destinationLong;
@property (retain)  MKPlacemark *thePlaceMark;
@property (retain)  CLLocation *theLocation;

- (void) locationUpdates;
- (IBAction)backButtonAction:(id)sender;
-(IBAction)routeAction:(id)sender;
- (void)segmentAction:(id)sender;
-(IBAction)viewDirections:(id)sender;

@end
