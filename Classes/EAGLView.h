//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "GlobeMarker.h"
#import "MarkersForGlobeList.h"
#import "SmoothRotator.h"
#import "MapViewController.h"
#import "PopUpViewController.h"


//for globe demo
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


typedef enum {
	none = 0,
	zoomIn,
	zoomedIn,
	zoomOut,
	zoomedOut
} ZoomEffect;

typedef enum {
	map = 0,       //Always show the countries' map
	natural       //Never show the coutries' map
} MapSwapState;

typedef enum{
    touchingMarker = 0,
    closestMarker,
    gpsCoordinates
} TouchBehavior;

/*
 This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView subclass.
 The view content is basically an EAGL surface you render your OpenGL scene into.
 Note that setting the view non-opaque will only work if the EAGL surface has an alpha channel.
 */
@interface EAGLView : UIView <CLLocationManagerDelegate, DismissPopDelegate, MKReverseGeocoderDelegate>{
    
@private
    /* The pixel dimensions of the backbuffer */
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    /* OpenGL names for the renderbuffer and framebuffers used to render to this view */
    GLuint viewRenderbuffer, viewFramebuffer;
    
    /* OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist) */
    GLuint depthRenderbuffer;
    
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
	
	GLuint m_texture[5][1];
	//GLuint m_texture[3][1];
	SmoothRotator * smoothRotator;
	float focalLengthX;
	float focalLengthY;
	float xSize;
	float ySize;
	float nearPlane;
	//Total Coordinates
	int totalCoordinates;
    GlobeMarker* markers[5000];
	GlobeMarker* theClosestMarker;
	float globeZSort;
	
	float diffX;
	float diffY;
	float rotX;
	float rotY;
	float viewWidth;
	float viewHeight;
	CGPoint firstTouch;
	CGPoint prevPoint;
	CGFloat previousDistance;
    CGFloat zoomFactor;
    BOOL moreThanOneFingerTouching; //this is in here to prevent weird rotation after zooming but letting go of one finger before the other
	float testLocation[3];
	
	float PI;
	BOOL looking;
	float offset;
	BOOL touchMomentum;
	float momentumX;
	float momentumY;
	float usersLat;
	float usersLon;
    float curLat;
	float curLon;
	float rotateBounds;
	int delayCount;
	ZoomEffect currentZoomEffect;
	MarkersForGlobeList *theMarkerList;
	GlobeMarker *theCurrentMarker;
	GlobeMarker *usersLocationMarker;
	MKPinAnnotationView *myView;
    MKReverseGeocoder *reverseGeocoder;
	CLLocation* touchedLocation;
	IBOutlet UIViewController *parentVC;
	
	//For Demo Globe
	BOOL showMarkers;
	MapSwapState mapSwapState;
    TouchBehavior touchBehavior;
	BOOL rotateOn;
    BOOL lightOn;
	CLLocationManager *locationManager;
    PopupViewController *popUpViewController;
    UIPopoverController *popoverController;
}

@property (nonatomic, assign) CGFloat zoomFactor;
@property (nonatomic, assign) GlobeMarker* theClosestMarker;
@property NSTimeInterval animationInterval;
@property (nonatomic, assign) BOOL looking;
@property (nonatomic, assign) float usersLat;
@property (nonatomic, assign) float usersLon;
@property (nonatomic, assign) ZoomEffect currentZoomEffect;
@property (nonatomic, assign) UIViewController *parentVC;
@property (nonatomic, assign) GlobeMarker *usersLocationMarker;

@property(nonatomic, retain) PopupViewController *popUpViewController;
@property(nonatomic, retain) UIPopoverController *popoverController;

// Add a globe marker to the surface of the globe.
- (void) addGlobeMarker:(GlobeMarker*)theMarker;

// This function is called by "addGlobeMarker" which translates the GPS coordinates
// of the "GlobeMarker" and translates them into x,y,z 3D space
- (void) addMarkerX: (float)xIn Y: (float) yIn Z: (float) zIn;

// Begins the animation process.  This MUST be called for the globe to be interactive
- (void) startAnimation;

// Stops the animation.  This is useful if you want to pause the animation while you transfer
// to a different view if this class will still be in memory.
- (void) stopAnimation;

// This is the main draw loop. This is where the majority of the opengl rendering code is
- (void) drawView;

// This function loads a texture by name and calls one of the two functions below based
// on if PVR or PNG images are being used
- (void) loadTexture: (int)index Name: (NSString*) name;

// PVR Textures take half the memory that using PNGs do.  The PVR must be created prior
// to distribution or downloaded dynamically since you can't create them on the fly
- (void) loadPVRTexture: (int)index Name: (NSString*) name;

// Requires more memory but allows for dynamically created images to be used as the globe texture
- (void) loadPNGTexture: (int)index Name: (NSString*) name;

// main function call to draw the globe markers
- (void) drawMarkers;

// call defines the render effect. If you had different marker types this function would be called
// for example if you had push pins, glowing dots, flags, etc this could switch between them
- (void) setGlobeMarkerRenderEffect: (GlobeMarkerRenderEffect) effect;

// The "GlobeMarker" contains a GPS location.  This function uses the SmoothRotator class to perform
// a smooth "Google Earth" type rotation to that point on the globe
- (void) lookAtMarker:(GlobeMarker*)theMarker;

// This function is called from the touch event to translate the x,y location of a persons finger
// on the screen to x,y,z coordinates and also the GPS coords of that touch
- (BOOL) raySphereIntersectX:(float)x andY:(float)y andVector:(Vector3 *)loc;

// Initializes the Marker List
- (void) initializeTheMarkerList;

// Helper function to get a random marker
- (void) getAsingleMarker;

// Uses the built in MKReverseGeocoder class to translate the users touch in Country,State,City data
- (void) reverseGeocodeLocation:(CLLocation*)theLocation;

// Pushes a Google Map view onto the screen matching dropping a pin on the location matching the users
// touch on the 3D globe
- (void) showMarkerOnGoogleMaps:(MKPlacemark*)thePlace;

// Helper function used for the iPad to rotate between landscape and portrait
- (void) initGlobeSizeByOrientation:(UIInterfaceOrientation)interfaceOrientation;

//For Demo Globe
-(IBAction)rotateConrolAction:(id)sender;
-(IBAction)markerControlAction:(id)sender;
-(IBAction)mapStateControlAction:(id)sender;
-(IBAction)curLocationButtonAction:(id)sender;
-(IBAction)showGoogleMaps:(id)sender;
-(IBAction)lightControlAction:(id)sender;
@end
