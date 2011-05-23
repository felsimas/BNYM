//
//  MapViewController.m
//  TravelGames
//
//  Created by Steven on 7/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#include <AudioToolbox/AudioToolbox.h>

@implementation MapViewController

@synthesize mapView;
@synthesize backButton;
@synthesize theSegmentedControl;
@synthesize parkingMapSelection;
@synthesize destinationLong;
@synthesize destinationLat;
@synthesize thePlaceMark;
@synthesize theLocation;

- (IBAction)backButtonAction:(id)sender{
	[self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)routeAction:(id)sender{
	NSLog(@"Route Button");
	
}

-(id)initWithPlaceMark:(MKPlacemark *)aPlace loc:(CLLocation*)aLocation{
	if (![super init]) return nil;
	self.thePlaceMark = aPlace;
	self.theLocation  = aLocation;
    return self;
}


- (void) locationUpdates{
	NSLog(@"Inside Location Update");
	//CLLocationCoordinate2D center;
	//if(lastLat != appDelegate.currentLat || lastLong != appDelegate.currentLong){
	//	annotation = nil;
	//center.latitude = appDelegate.currentLat;
	//	center.longitude = appDelegate.currentLong;
	//	annotation = [[MyAnnotation alloc] initWithCoordinate: center];
	//	annotation.title = [NSString stringWithFormat:@"My Location"];
		
	//	lastLat = appDelegate.currentLat;
	//	lastLong = appDelegate.currentLong;
	//}
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"BEGIN: vwa in MapViewController");
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	theSegmentedControl.selectedSegmentIndex = 0;
	
	[theSegmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	
	CLLocationCoordinate2D center;
	center.latitude = self.theLocation.coordinate.latitude;
	center.longitude = self.theLocation.coordinate.longitude;
	
	MKCoordinateRegion myRegion;
	myRegion.span.latitudeDelta = 17;
	myRegion.span.longitudeDelta = 17;
	myRegion.center = center;
	
	mapView.region = myRegion;
	
	if([self.thePlaceMark addressDictionary]){
		[mapView addAnnotation:self.thePlaceMark];
	}else {
		MyAnnotation *annOne;
		annOne = [[MyAnnotation alloc] initWithCoordinate: center];
		annOne.title = @"Your Touch";
		[mapView addAnnotation:annOne];
	}
	
}


- (void)segmentAction:(id)sender
{
	NSLog(@"segmentAction: selected segment = %d", [sender selectedSegmentIndex]);
	
	switch ([sender selectedSegmentIndex]) {
		case 0:
			mapView.mapType = MKMapTypeStandard;
			NSLog(@"segment case 0");
			break;
		case 1:
			mapView.mapType = MKMapTypeSatellite;
			NSLog(@"segment case 1");
			break;
		case 2:
			mapView.mapType = MKMapTypeHybrid;
			NSLog(@"segment case 2");
			break;
		default:
			break;
	}
	[self.view setNeedsDisplay];
}


-(IBAction)viewDirections:(id)sender{
	NSLog(@"viewDirections pushed");
	NSLog(@"Users Location Lat = %f, Long = %f", [mapView userLocation].coordinate.latitude, [mapView userLocation].coordinate.longitude);
	
	
	/*NSString *directionsLink = @"http://maps.google.com/maps?f=d&source=s_d&saddr=";
	directionsLink = [directionsLink stringByAppendingString:[NSString stringWithFormat:@"%f", [mapView userLocation].coordinate.latitude]];
	directionsLink = [directionsLink stringByAppendingString:@","];
	directionsLink = [directionsLink stringByAppendingString:[NSString stringWithFormat:@"%f", [mapView userLocation].coordinate.longitude]];
	directionsLink = [directionsLink stringByAppendingString:@"&daddr="];
	directionsLink = [directionsLink stringByAppendingString:[NSString stringWithFormat:@"%f",propertyModel.latitude]];
	directionsLink = [directionsLink stringByAppendingString:@","];
	directionsLink = [directionsLink stringByAppendingString:[NSString stringWithFormat:@"%f",propertyModel.longitude]];
	
	NSURL *theUrl = [NSURL URLWithString:directionsLink];
	[[UIApplication sharedApplication] openURL:theUrl];*/
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
	//mapView.showsUserLocation = YES;
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.mapView release];
	[self.thePlaceMark release];
	[self.theLocation release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	NSLog(@"BEGIN: shouldAutorotateToInterfaceOrientation");
	
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		return YES;
	else {
		//it is an iPhone so don't auto rotate
		return NO;
	}
	
	
}

@end
