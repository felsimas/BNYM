//  Copyright 2011 Logic Diner. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "GlobeConstants.h"
#import "EAGLView.h"
#import "Hemisphere.h"

#define USE_DEPTH_BUFFER 1
#define USE_PVR_TEXTURES 1

// set according to project needs

//MARKING_SPHERE allows the user to place little "markers" on the globe when double tapping
#define MARKING_SPHERE 0

//also TOUCHING_MARKER_PROJECTIONS is defined (or not) in GlobeMarker.h

static GLfloat flippedNormals[500*3];
// A class extension to declare private methods
@interface EAGLView ()

@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) NSTimer *animationTimer;

- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

@end

@implementation EAGLView

@synthesize context;
@synthesize animationTimer;
@synthesize animationInterval;
@synthesize looking;
@synthesize usersLat;
@synthesize usersLon;
@synthesize currentZoomEffect;
@synthesize parentVC;
@synthesize usersLocationMarker;
@synthesize theClosestMarker;
@synthesize zoomFactor;
@synthesize delegate;
@synthesize popUpViewController;
@synthesize popoverController;
// You must implement this method
+ (Class)layerClass {
    return [CAEAGLLayer class];
}

//this needs to be call when the view is initialized 
// and when the device rotates if rotation is supported in the app
- (void)initGlobeSizeByOrientation:(UIInterfaceOrientation)interfaceOrientation{
	NSLog(@"BEGIN: initGlobeSizeByOrientation");
	GLfloat size = .01 * tanf(45.0f*3.1415f/360.0f);
	
	viewWidth = self.bounds.size.width;
	viewHeight = self.bounds.size.height;
	
	if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
		NSLog(@"Orientation is Landscape");
		//viewWidth = self.bounds.size.height;
		//viewHeight = self.bounds.size.width;
		size = .01 * tanf(45.0f*3.1415f/240.0f);
	}
	xSize = size;
	ySize = size * (viewHeight/viewWidth);
	nearPlane = 0.01;
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	glFrustumf(-size, size, -ySize, ySize, nearPlane, 100);
	
	float matrix[16];
	glGetFloatv(GL_PROJECTION_MATRIX, matrix);
	focalLengthX = matrix[0];
	focalLengthY = matrix[5];
	NSLog(@"focal lengths %f, %f", matrix[0], matrix[5]);
}

- (void) SetUpLights {
	GLfloat light_position[] = { 2.0, 0.0, 2.0, 0.0 };
	glClearColor (0.0, 0.0, 0.0, 0.0);
	glShadeModel (GL_SMOOTH);
	
	glLightfv(GL_LIGHT0, GL_POSITION, light_position);
    
}
- (void) SetLightingModel:(BOOL)lightsOn {
	
	if (lightsOn) {
        /*	glEnable(GL_DEPTH_TEST);
         glEnable(GL_BLEND);
         glEnable(GL_TEXTURE_2D);
         
         glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
         
         //		glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
         //glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
         //		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
         
         glEnable(GL_LIGHTING);
         glEnable(GL_LIGHT0);
         glEnable(GL_DEPTH_TEST);
         
         */
        
        glEnable(GL_DEPTH_TEST);
		glEnable(GL_BLEND);
		glEnable(GL_TEXTURE_2D);
		glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
		//glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        
		glDisable(GL_LIGHTING);
		glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	}
	else {
		glEnable(GL_DEPTH_TEST);
		glEnable(GL_BLEND);
		glEnable(GL_TEXTURE_2D);
		glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
		//glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        
		glDisable(GL_LIGHTING);
		glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	}
    
}

//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {
    
    if ((self = [super initWithCoder:coder])) {
        // Get the layer
		self.clipsToBounds = YES;
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = YES;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }
        for(int i = 0; i < 1500; i++) {
			flippedNormals[i] = -HemisphereNormals[i];
		}
        
        lightOn = YES;
		[self SetUpLights];
		[self SetLightingModel:lightOn];
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
        
		[self initGlobeSizeByOrientation:self.parentVC.interfaceOrientation];
		
       [self loadTexture: 0 Name: @"xxx"];
   //[self setBackgroundColor:[UIColor blackColor]];
        
        
		//texture 0 is the stars
       //   [self loadTexture: 0 Name: @"Stars"];
        
        //textures 1 & 2 are the left and right side of the world with country names and borders
        [self loadTexture: 1 Name: @"PlainGlobe_Left"];
        [self loadTexture: 2 Name: @"PlainGlobe_Right"];
        
        
        //[self loadTexture: 0 Name: @"Background.png"];
        
        //texture 3 & 4 are the left and right sides of the world without the countries
        //[self loadTexture: 3 Name: @"PlainGlobe_Left"];
        //[self loadTexture: 4 Name: @"PlainGlobe_Right"];
        
        animationInterval = 1.0 / 60.0;
		
		smoothRotator = [[SmoothRotator alloc] init];
		
		srandom(time(NULL));
		
		//this function initializes The list used for the talk bubble effect
		totalCoordinates = 0;
		[self initializeTheMarkerList];
        
        //This is setting the default marker effect.
		//[self setGlobeMarkerRenderEffect: pin]; 
		
		//these three variables for to let the globe continue to rotate after a uses ends their touch
		touchMomentum = NO;
		momentumX = 0;
		momentumY = 0;
		
		rotX = 0;
		rotY = 90.0;
		zoomFactor = (MAX_ZOOM_OUT + MAX_ZOOM_IN) / 2;
		rotateBounds = 70;
		PI = 3.1416;
		offset = 0.0;
		
		self.exclusiveTouch = YES;
		[self startAnimation];
        NSLog(@"5");
		//for demo globe
		mapSwapState = map;
		showMarkers = YES;
		rotateOn = YES;
		currentZoomEffect = zoomOut;
		looking = NO;
		
		if(!locationManager){
			usersLat = -999;
			usersLon = -999;
			usersLocationMarker = [[GlobeMarker alloc] init];
			NSLog(@"starting Location manager in vwa");
			locationManager = [[CLLocationManager alloc] init];
			[locationManager setDelegate:self];
			[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
			if(!locationManager.locationServicesEnabled)
			{
				//aTextView.text = @"Location Services Not enabled";
			}
			[locationManager startUpdatingLocation];
			
		}
		[self getAsingleMarker];
		[self lookAtMarker:theCurrentMarker];
        NSLog(@"6");
        
		//end for demo globe
    }
    return self;
}

//This function gets a Marker
- (void) getAsingleMarker{
	
	BOOL keepGoing;
	
	keepGoing = YES;
	
	curLat = theCurrentMarker.location.coordinate.latitude;
	curLon = theCurrentMarker.location.coordinate.longitude;
	int infiniteCheck = 0;
	
	// this has been put in a while loop so that we can make sure the 
	// random marker we chose is far enough away
	// there is an variable to make sure we don not get stuck in an infinite loop
	while(keepGoing)
	{
		infiniteCheck++;
		int markerCount = [theMarkerList.theList count];
		int randomMarkerIndex = random()%markerCount;
        
		theCurrentMarker = [theMarkerList.theList objectAtIndex:randomMarkerIndex];
		
		// after getting a random location this if statements makes sure the new location is far enough away
		// to get a good rotation effect
		if((abs(theCurrentMarker.location.coordinate.latitude - curLat) > 100 && 
			abs(theCurrentMarker.location.coordinate.longitude - curLon) > 30) ||
		   infiniteCheck > 30)
			keepGoing = NO;
	}
}

//this function initializes The list used for the talk bubble effect
//if you use sql insteady of the array you will not need this function
- (void) initializeTheMarkerList{
	//This code is to draw the markers on the globe
	theMarkerList = [[MarkersForGlobeList alloc] init];
}

//Add a marker at latitude lat and longitude lon
- (void)addGlobeMarker:(GlobeMarker*)theMarker{
	
	float lat, lon;
	lat = theMarker.location.coordinate.latitude;
	lon = theMarker.location.coordinate.longitude;
	
	//adjust lat and lon for offset of 3D model
	lat = 90 - lat;
	lon = -lon;
	
	float lat_rad = (lat * M_PI)/180;
	float lon_rad = (lon * M_PI)/180;
	
	//convert from spereical coordinates
	//see http://en.wikipedia.org/wiki/Spherical_coordinates
	
	float x = cos(lon_rad) * sin(lat_rad);
	float y = sin(lon_rad) * sin(lat_rad);
	float z = cos(lat_rad);
	
	[self addMarkerX: x Y: y Z: -z];
}

- (void)addMarkerX: (float)xIn Y: (float) yIn Z: (float) zIn
{
	
	markers[ totalCoordinates ] = [[GlobeMarker alloc] initWithX: xIn Y: yIn Z: zIn ];
	totalCoordinates++;
}

- (void) setGlobeMarkerRenderEffect: (GlobeMarkerRenderEffect) effect
{
	for( int i = 0; i < totalCoordinates; i++ )
		markers[i]->currentEffect = effect;
}

//Look at any GPS coord on the globe
- (void) lookAtMarker:(GlobeMarker*)theMarker;
{	
	NSLog(@"BEGIN: lookAtMarker");
	float lat, lon;
	rotateOn = NO;
	curLat   = theMarker.location.coordinate.latitude;
	curLon   = theMarker.location.coordinate.longitude;
	lat = curLat;
	lon = curLon;
	NSLog(@"     : break 1");
	
	//convert from spereical coordinates
	//see http://en.wikipedia.org/wiki/Spherical_coordinates
	lat = 90 - lat;
	lon = -lon;
	float lat_rad = (lat * M_PI)/180;
	float lon_rad = (lon * M_PI)/180;
	
	float x = cos(lon_rad) * sin(lat_rad);
	float y = sin(lon_rad) * sin(lat_rad);
	float z = cos(lat_rad);
	
	Vector3 endPoint;
	endPoint[0] = x;
	endPoint[1] = y;
	endPoint[2] = -z;
	
	//smooth rotator class is used to acheieve the smooth rotation between too points
	[smoothRotator newRotationFromLat: rotY andLon: rotX toPoint: endPoint withAngularSpeed: ROTATION_SPEED];
	looking = YES;
}


#define BIG_DOUBLE_NUMBER 9999999999999
//test distanceSquared from each marker point to find which one is closest (this is not a spherically accurate "great circe" sort of check, just a quick check)
- (GlobeMarker*) getClosestMarkerToThisLatitude:(float)lat_deg andLongitude:(float)lon_deg {
	int closestMarkerIndex = 0;
	double closestDistance = BIG_DOUBLE_NUMBER;
	float deltaLat;
	float deltaLong;
	double testDistance;
	CLLocation* tLocation;
	for (int i = 0; i < totalCoordinates; i++) {
		tLocation = ((GlobeMarker*)[theMarkerList.theList objectAtIndex:i]).location;
		deltaLat = tLocation.coordinate.latitude - lat_deg;
		deltaLong =  tLocation.coordinate.longitude - lon_deg;
		testDistance = deltaLat*deltaLat + deltaLong*deltaLong;
		if (testDistance < closestDistance) {
			closestDistance = testDistance;
			closestMarkerIndex = i;
		}
	}
	return markers[closestMarkerIndex];
	
}


/**
 **  return YES for an intersection, put coordinates in loc.  Put fatcircle, if you want to test marks tagged on a bigger circle
 **/
- (CLLocation*) coordinatesFromRaySphereIntersectX:(float)x andY:(float)y andVector:(Vector3 *)loc withFatness:(BOOL)fatCircle{
	Vector3 ray;
	Vector3 sphere;
	float radius = GLOBE_RADIUS;
	if (fatCircle)
		radius *= (1 + kSeparationFromGlobeFactor);
	//viewWidth = self.bounds.size.width;
	//viewHeight = self.bounds.size.height;
    
	float xc = viewWidth / 2;
	float yc = viewHeight / 2;
	NSLog(@"xc = %f :: yc = %f", xc, yc);
	ray[0] = (x - xc) / viewWidth;
	ray[1] = ((y - yc) / viewHeight) * focalLengthX / focalLengthY;
	ray[2] = focalLengthX;
	
	// normalize ray
	float rayMag = sqrt(ray[0] * ray[0] + ray[1] * ray[1] + ray[2] * ray[2]);
	ray[0] /= rayMag;
	ray[1] /= rayMag;
	ray[2] /= rayMag;
	
	
	// sphere position depends on zoomFactor
	GLfloat zoomScaler = MAX_ZOOM_OUT - zoomFactor + 0.00000001; //at 8 the earth fill the globe + add small number for divide by zero check
	zoomScaler = -zoomFactor + zoomScaler/8;
	sphere[0] = 0;
	sphere[1] = 0;
	sphere[2] = zoomScaler;
	//NSLog(@"zoomScaler = %f",zoomScaler);
    
	
	// solve quadratic equation
	float A = ray[0] * ray[0] + ray[1] * ray[1] + ray[2] * ray[2];
	float B = -2 * sphere[0] * ray[0] - 2 * sphere[1] * ray[1] - 2 * sphere[2] * ray[2];
	float C = sphere[0] * sphere[0] + sphere[1] * sphere[1] + sphere[2] * sphere[2] - (radius * radius);
	
	
	// touched outside the globe
	float det = B * B - 4 * A * C;
	if (det < 0)
		return NO;
	
	
	float sqt = sqrt(det);
	float A2 = 2 * A;
	float t1 = (-B + sqt) / (A2);
	float t2 = (-B - sqt) / (A2);
	
	// take the "front" side in case there are two intersections
	float tmin = (t1 < t2) ? t1 : t2;
	
	// get the result
	Vector3 result;
	result[0] = tmin  * ray[0];
	result[1] = tmin  * ray[1];
	result[2] = (tmin * ray[2] + zoomFactor);
	
	// normalize the result
	float resultMag = sqrt(result[0] * result[0] + result[1] * result[1] + result[2] * result[2]);
	result[0] /= resultMag;
	result[1] /= resultMag;
	result[2] /= resultMag;
	
	// rotate the result to account for current rotX and rotY
	Vector3 result2;
	float rotAboutX = (180 - rotY) * M_PI / 180;
	// about X axis
	result2[0] = result[0];
	result2[1] = result[1] * cosf(rotAboutX) - result[2] * sinf(rotAboutX);
	result2[2] = result[1] * sinf(rotAboutX) + result[2] * cosf(rotAboutX);
	
	Vector3 result3;
	float rotYR = (rotX) * M_PI / 180;
	// about Z axis
	result3[0] = result2[0] * cosf(rotYR) - result2[1] * sinf(rotYR);
	result3[1] = result2[0] * sinf(rotYR) + result2[1] * cosf(rotYR);
	result3[2] = result2[2];
	
	(*loc)[0] = result3[0];
	(*loc)[1] = result3[1];
	(*loc)[2] = result3[2];
	
	
	float lat, lat_deg;
	float lon, lon_deg;
	lat = acos( ((*loc)[2]) / ( sqrt( (*loc)[0] * (*loc)[0] + (*loc)[1] * (*loc)[1] + (*loc)[2] * (*loc)[2] ) ));
	lon = atan2((*loc)[1],(*loc)[0]);
	
	lat_deg = lat * (180/M_PI);
	lon_deg = lon * (180/M_PI);
	
	//adjust lat and lon for offset of 3D model
	lat_deg = lat_deg - 90;
	lon_deg = -lon_deg;
	
	NSLog(@"User touched: lat = %f :: lon = %f",lat_deg, lon_deg);
	
	touchedLocation = [[CLLocation alloc] initWithLatitude:lat_deg longitude:lon_deg];
	return touchedLocation;
}



// ------------------------- touch checks ------------------------------------------------------------------------------
// these routines are useful in handling touch checks on the window
//
//

//Checks for touches on the globe, and sets a marker down accordingly
- (BOOL) raySphereIntersectX:(float)x andY:(float)y andVector:(Vector3 *)loc {
	CLLocation* touchedSpot = [self coordinatesFromRaySphereIntersectX:x andY:y andVector:loc withFatness:NO];
	BOOL useReverGeocoder = NO;
	//With MKReverseGeocoder code  if you go over your quota the app stops working
	if (useReverGeocoder) {
		[self reverseGeocodeLocation:touchedLocation];
	}else {
		//This just converts the touches to lat and long to pass to google maps with a pin drop at that location
		NSDictionary *addressDic = nil;
		
		MKPlacemark *thePlace = [[MKPlacemark alloc] initWithCoordinate:touchedSpot.coordinate addressDictionary:addressDic];
		[self showMarkerOnGoogleMaps:thePlace];
	}
	
	return YES;
}

- (GlobeMarker*)closestMarkerToThisTouchAtX:(float)x andY:(float)y andVector:(Vector3 *)loc {
	CLLocation* touchedSpot = [self coordinatesFromRaySphereIntersectX:x andY:y andVector:loc withFatness:NO];
	return [self getClosestMarkerToThisLatitude:touchedSpot.coordinate.latitude andLongitude:touchedSpot.coordinate.longitude];
}

- (GlobeMarker*)touchingMarkerAtThisTouchAtX:(float)x andY:(float)y{
	float ray[3];
	
	float xc = viewWidth / 2;
	float yc = viewHeight / 2;
	
	//interesting--these two ray calculations lead to the same results.  It give me hope for mathemetics...
    
	ray[0] = ((x - xc) / viewWidth)* xSize * 100;	//*100 for easier debugging numbers
	ray[1] = ((y - yc) / viewHeight) * ySize * 100;
	ray[2] = nearPlane * 100;
    
	ray[0] = ray[0]/ray[2];
	ray[1] = ray[1]/ray[2];
	ray[2] = 1.0;
	
	//alternate raycasting method
    //	ray[0] = (x - xc) / viewWidth;
    //	ray[1] = ((y - yc) / viewHeight) * focalLengthX / focalLengthY;
    //	ray[2] = focalLengthX;
    //	ray[0] = ray[0]/ray[2];
    //	ray[1] = ray[1]/ray[2];
    //	ray[2] = 1.0;
    //	NSLog(@"Rays2 is (%f, %f, %f)", ray[0], ray[1], ray[2]);
    //	NSLog(@"FocalLengthx, y is (%f, %f)", focalLengthX, focalLengthY);
    
	// sphere position depends on zoomFactor
	GLfloat zoomScaler = MAX_ZOOM_OUT - zoomFactor + 0.00000001; //at 8 the earth fill the globe + add small number for divide by zero check
	zoomScaler = -zoomFactor + zoomScaler/8;
    
	float adjustedRotAboutY = rotX - 270.0;//the helpful rotx and roty for movement, need to be adjusted to help us rotate the sphere for checks
	float adjustedRotAboutX = -rotY + 90.0;
    
	GlobeMarker* bestMarker = nil;
	GlobeMarker* tMarker;
	float bestDepth = -999999.0; //big negative number
	for (int i =0; i < totalCoordinates; i++) {
		
		tMarker = markers[i];
		float depth;
		if ([tMarker isMarkerBeingTouched:&ray[0] globeOffset:zoomFactor + 1 globeRotateX:adjustedRotAboutX globeRotateY:adjustedRotAboutY atDepth:&depth]  ) {
			float adjustedDepth = depth - globeZSort;
			if (adjustedDepth > bestDepth && adjustedDepth > IGNORE_MARKS_BEHIND_THIS_DEPTH) {
				bestDepth = adjustedDepth;
				bestMarker = tMarker;
			}
		}
	}
	if (bestMarker != nil)
		NSLog(@"touched Mark");
	return bestMarker;
}

// ------------------------- touch checks ------------------------------------------------------------------------------




//function prints the center of the Globe
- (void)printCenterCoordsOfGlobe{
	float lat_deg = rotY - 90;
	float lon_deg = 0;
	
	//need to adjust rotX for offset
	if(rotX >= 90) lon_deg = rotX - 270;
	else           lon_deg = rotX + 90;
	
	lon_deg = -lon_deg;
	
	NSLog(@"CENTER OF GLOBE: lat = %f :: lon = %f", lat_deg, lon_deg);
}

//touchesBegan is called everything a user first touches the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touches began");
	//[self printCenterCoordsOfGlobe];
    
	
	// set variables to turn off all effect while the user navigates the globe
	momentumX = 0;
	momentumY = 0;
	touchMomentum = NO;
	delayCount = 0;
	looking = NO;
	
	if(event.allTouches.count == 2) {
		//if there are two touches the user is most like trying to zoom in or out on the globe
		NSArray *touches = [event.allTouches allObjects];
		CGPoint pointOne = [[touches objectAtIndex:0] locationInView:self];
		CGPoint pointTwo = [[touches objectAtIndex:1] locationInView:self];
		previousDistance = sqrt(pow(pointOne.x - pointTwo.x, 2.0f) + 
								pow(pointOne.y - pointTwo.y, 2.0f));
        moreThanOneFingerTouching = YES; //this is to prevent a weird rotation if you are zooming in and then let go of one finger but not the other
	} else if(event.allTouches.count == 1)
	{
        moreThanOneFingerTouching = NO; //to prevent weird rotation on zooming.  Set no here since we are no longer zooming
		NSArray *touch = [event.allTouches allObjects];
		CGPoint point = [[touch objectAtIndex:0] locationInView:self];
		prevPoint = point;
		firstTouch = point;
		
		if([[touch objectAtIndex:0] tapCount] > 1)
		{			
			looking = NO;
			NSLog(@"this is being called when a users double taps the screen");
			
			//CGPoint point = [[touch objectAtIndex:0] locationInView:self];
			
			//NSLog(@"x = %f, y = %f", point.x, point.y);
			
			
#if MARKING_SPHERE
			UITouch * touch = [touches anyObject];
            
			CGPoint point = [touch locationInView: self];
			Vector3 loc;
            
            BOOL hitSphere = [self raySphereIntersectX: point.x andY: point.y andVector: &loc];
            if (hitSphere) {				
                NSLog(@"touch at (%f, %f, %f)", loc[0], loc[1], loc[2]);
                [smoothRotator newRotationFromLat: rotY andLon: rotX toPoint: loc withAngularSpeed: ROTATION_SPEED];
                [self addMarkerX: loc[0] Y: loc[1] Z: loc[2]];
                looking = YES;
            }
#endif
			
		}
	}
}
//END:code.PinchZoomView.touchesBegan


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	delayCount = 0;
	
	if(event.allTouches.count == 2) {
		NSArray *touches = [event.allTouches allObjects];
		CGPoint pointOne = [[touches objectAtIndex:0] locationInView:self];
		CGPoint pointTwo = [[touches objectAtIndex:1] locationInView:self];
		CGFloat distance = sqrt(pow(pointOne.x - pointTwo.x, 2.0f) + 
								pow(pointOne.y - pointTwo.y, 2.0f));
		
		zoomFactor += ZOOM_TOUCH_MULTIPLIER * (distance - previousDistance) / previousDistance; 
		
		previousDistance = distance;
		
		//check to make sure zoomFactor is not to big or to small
		if (zoomFactor > MAX_ZOOM_IN)
            zoomFactor = MAX_ZOOM_IN;
        else if(zoomFactor < MAX_ZOOM_OUT)
            zoomFactor = MAX_ZOOM_OUT;
		
	}else if([touches count] == 1)
	{
		UITouch *touch = [[event allTouches] anyObject];
		
		CGPoint touchPoint = [touch locationInView:self];
		
        if(!moreThanOneFingerTouching){
            diffX = (touchPoint.x - prevPoint.x);
            diffY = (touchPoint.y - prevPoint.y);
            
            //adjust for zoom level - rotate less when zoomin in MAX_ZOOM_OUT / MAX_ZOOM_OUT = 1 & -5/MAX_ZOOM_OUT
            float scaleFactorForDiff = zoomFactor / -45;
            momentumX = diffX * scaleFactorForDiff;
            momentumY = diffY * scaleFactorForDiff;		
            
            //set rotX and rotY which are the main variables that determine the appearance of the globe
            rotX += momentumX;
            rotY += momentumY;
            
            // setting prevPoint to the current "touchPoint" allows us to use it the next time the touchesMoved function is called
            prevPoint = touchPoint;	
            
            //keep globe from rotating past the poles
            if( rotY >= 90 + rotateBounds ) rotY = 90 + rotateBounds;
            if( rotY <= 90 - rotateBounds ) rotY = 90 - rotateBounds;
        }else{
            // If more than one finger was touching then they lift one but not the other there is a
            // potential for the normal calculations to use the wrong prevPoint
            // so just set these two variable so the next call the prevPoint is from the one finger
            // that was left touching
            moreThanOneFingerTouching = NO;
            prevPoint = touchPoint;	
        }
	} 
}

//native function that is called when the user ends their touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	previousDistance = 0.0f;
	
	if([touches count] != 1 || moreThanOneFingerTouching)
	 	return;
	
	// This code was added to detect for a single tap
	// It checks the difference between the first and last touches
	
	UITouch *touch = [[event allTouches] anyObject];
	if([touch tapCount] == 1){
		CGPoint touchPoint = [touch locationInView:self];
		
		diffX = abs(touchPoint.x - firstTouch.x);
		diffY = abs(touchPoint.y - firstTouch.y);
		
		float totalDiff = diffX + diffY;
		NSLog(@"point is %f : %f || %f : %f || tot = %f",firstTouch.x, firstTouch.y, touchPoint.x, touchPoint.y, totalDiff);
		
		if(totalDiff < 12)
		{
			
			Vector3 loc;
            
            UIAlertView *alert;
            
            switch (touchBehavior) {
                case touchingMarker:
                    //this will return a nil to closestMarker if nothing is touched
                    theClosestMarker = [self touchingMarkerAtThisTouchAtX:firstTouch.x andY:firstTouch.y];
                    if(theClosestMarker != nil){
                        
                        [self showPopupWindow:theClosestMarker];
                        /*  alert =
                         [[UIAlertView alloc] initWithTitle: @"Marker Touched"
                         message: @"You Touched a marker"
                         delegate: self
                         cancelButtonTitle: @"OK"
                         otherButtonTitles: nil];
                         [alert show];
                         [alert release]; */
                    }
                    break;
                case closestMarker:
                    theClosestMarker = [self closestMarkerToThisTouchAtX:firstTouch.x andY:firstTouch.y andVector:&loc];
                    break;
                case gpsCoordinates:
                    [self raySphereIntersectX: firstTouch.x andY: firstTouch.y andVector: &loc];
                    break;
                default:
                    break;
            }
		}
	}
	
	//NSLog(@"touches ended: mX = %f :: mY = %f", momentumX, momentumY);
	delayCount = 0;
	touchMomentum = YES; //turn touchMomentum on so the globe keeps moving after the touch ends
	
	//this set of checks makes sure the globe does not rotate to fast after letting go
	int tranValue = zoomFactor * -1.2;
	if (momentumX > tranValue)
		momentumX = tranValue;
	if (momentumX < -tranValue)
		momentumX = -tranValue;
	if (momentumY > tranValue)
		momentumY = tranValue;
	if (momentumY < -tranValue)
		momentumY = -tranValue;	
	
	// this block of code makes sure the globe stays still have the user
	// as navigated to a place on the globe.
	if(momentumX < 2 && momentumY < 2 && momentumX > -2 && momentumY > -2)
	{  touchMomentum = NO;  momentumX = 0; momentumY = 0; }
}



// drawView is called inside of the view display loop
// this is the loop that is rendering the globe
- (void)drawView {
	
	
	if (looking) {
		// if the globe is rotating between point looking will be try
		// if this is happening then we need to set rotX and rotY which will determine 
		// the rotation of the globe
		BOOL doneWithRotation = [smoothRotator stepRotation];
		if (doneWithRotation)
			looking = NO;		
		rotX = smoothRotator.rotX;
		rotY = smoothRotator.rotY;
	}
	else {
		// touchMomentum is true only after a person has finished touching the screen on the device
		// this logic allows the globe to smoothly continue to rotate naturally slowing down on its own instead of stopping immediately
		if(touchMomentum)
		{
			rotX += momentumX;
			rotY += momentumY;
			
			if(momentumY >= MOMENTUM_STOP)
				momentumY -= (momentumY/MOMENTUM_CONSTANT);
			else if (momentumY <= -MOMENTUM_STOP)
				momentumY -=(momentumY/MOMENTUM_CONSTANT);
			else
				momentumY = 0;
			
			if(momentumX >= MOMENTUM_STOP)
				momentumX -= (momentumX/MOMENTUM_CONSTANT);
			else if (momentumX <= -MOMENTUM_STOP)
				momentumX -= (momentumX/MOMENTUM_CONSTANT);
			else
				momentumX = 0;
			
			//if the momentum get below a certain point than just turn it off
			if(momentumY <= MOMENTUM_STOP && momentumY >= -MOMENTUM_STOP && 
			   momentumX <= MOMENTUM_STOP && momentumX >= -MOMENTUM_STOP)
			{
				//NSLog(@"turn momentum off");
				touchMomentum = NO;
			}
		}
	}
	
	//keep globe from rotating past the poles
	if( rotY >= 90 + rotateBounds ) rotY = 90 + rotateBounds;
	if( rotY <= 90 - rotateBounds ) rotY = 90 - rotateBounds;
	
	//make sure rotX and Y are always in range
	if( rotX < 0 ) rotX += 360;
	if( rotX > 360 ) rotX -= 360;
	if( rotY < 0 ) rotY += 360;
	if( rotY > 360 ) rotY -= 360;
	
	// this block of code creates the effect of zooming out and then in
	// as you rotate from one point to the other.  (Like google earth does it)
	
	if(looking)
	{
		switch(currentZoomEffect)
		{
			case zoomIn:
				if(zoomFactor < MAX_ZOOM_IN)
					zoomFactor += ZOOM_IN_FACTOR;
				else
					currentZoomEffect = zoomedIn;
				break;
			case zoomOut:
				if(zoomFactor > MAX_ZOOM_OUT)
					zoomFactor -= ZOOM_OUT_FACTOR;
				else
					currentZoomEffect = zoomedOut;
				break;
			case zoomedIn:
				//Look around effect for demo globe
				if(delayCount > 40)
				{
					delayCount = 0;
					[self getAsingleMarker];
					[self lookAtMarker:theCurrentMarker];
					currentZoomEffect = zoomOut;
				}else{
					delayCount++;
				}
				break;
			case zoomedOut:
				break;
			case none:
			default:
				break;
		}
		
		if(looking && currentZoomEffect != zoomedIn)
		{
			int halfNumSteps = (int) (smoothRotator.numSteps * .5);
			
			if(smoothRotator.currentStep > halfNumSteps) 		
				currentZoomEffect = zoomIn;
			else 		
				currentZoomEffect = zoomOut;
		} 
	}
	//end of zoom out and then in effect block of code
	
	//opengl es rendering code this is where most of the rendering happens
	glPushMatrix();
    [EAGLContext setCurrentContext:context];
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);
    
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
	glTranslatef(0, 0, zoomFactor);
	
	glRotatef(rotY, 1.0f, 0.0f, 0.0f);
	glRotatef(-rotX, 0.0f, 0.0f, 1.0f);
	
	glScalef(3.0f, 3.0f, 3.0f);
	
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	glVertexPointer(3, GL_FLOAT, 0, HemisphereVertices);
    //	glNormalPointer(GL_FLOAT, 0, HemisphereNormals);
	glNormalPointer(GL_FLOAT, 0, HemisphereVertices);
	glTexCoordPointer (2, GL_FLOAT, 0, HemisphereTexture);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glPushMatrix();
	glTranslatef( 0, 0, -1);
	glScalef( -.333, .333, .333 );
	glPushMatrix();
    
	float result[16];
	glGetFloatv(GL_MODELVIEW_MATRIX, &result[0]);
	globeZSort = result[14];
	glRotatef(-90, 0.0f, 0.0f, 1.0f); //this is to offset the globe 
	
	//Draw the Sphere
	glColor4f(1, 1, 1, 1); 
	
	
    //Load Texture for left side of globe
    glBindTexture(GL_TEXTURE_2D, m_texture[1][0]);
    
	//for globe demo.  It is used to chose between mulitple version of the globe texture
	/*switch (mapSwapState) {
     case map:
     glBindTexture(GL_TEXTURE_2D, m_texture[1][0]);
     break;
     case natural:
     glBindTexture(GL_TEXTURE_2D, m_texture[3][0]);
     break;
     }*/
	
	for (unsigned int i = 0; i < HemisphereIndexCount/3; i++) {
		glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, &HemisphereIndices[i * 3]);
	}
	
	//this small rotation helps the seems of the left and right line up right
	//glTranslatef( -.01, .025, 0 );
	glTranslatef( -.01, 0.025, 0 );
	
	//RIGHT HEMISPHERE
	glRotatef( 180, 0, 0, 1 );
	
	
    //Load Texture for right side of globe
	glBindTexture(GL_TEXTURE_2D, m_texture[2][0]);
	
	
	//for globe demo.  It is used to chose between mulitple version of the globe texture
	/*switch (mapSwapState) {
     case map:
     glBindTexture(GL_TEXTURE_2D, m_texture[2][0]);
     break;
     case natural:
     glBindTexture(GL_TEXTURE_2D, m_texture[4][0]);
     break;
     }*/
	//glBindTexture(GL_TEXTURE_2D, m_texture[3][0]);
	
	for (unsigned int i = 0; i < HemisphereIndexCount/3; i++) {
		glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, &HemisphereIndices[i * 3]);
	}
	
    
    
	//Draw the skybox (stars)
	glColor4f(1, 1, 1, 1);
	glScalef(10,10,10);
	glTranslatef( 0, 0, -2 );
	
	GLboolean lighton;
	glGetBooleanv(GL_LIGHTING, &lighton);
	if (lighton)
		[self SetLightingModel:NO];
	//LEFT HEMISHPERE OF STARS (Stars are drawn on the inside of a sphere that is much larger than the globe
	glBindTexture(GL_TEXTURE_2D, m_texture[0][0]);
	for (unsigned int i = 0; i < HemisphereIndexCount/3; i++) {
		glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, &HemisphereIndices[i * 3]);
	}
	
	//this small rotation helps the seems of the left and right line up right
	glTranslatef( -.01, .025, 0 );
	
	//RIGHT HEMISPHERE OF STARS (Stars are drawn on the inside of a sphere that is much larger than the globe
	glRotatef( 180, 0, 0, 1 );
	
	for (unsigned int i = 0; i < HemisphereIndexCount/3; i++) {
		glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, &HemisphereIndices[i * 3]);
	}
	
	glPopMatrix();
	glPopMatrix();
	
	//Draw markers
	
	glColor4f(1, 1, 1, 0); 
	glTranslatef( 0.0, -1.0, 0.0 );
	if(showMarkers)
		[self drawMarkers];
	
	if (lighton)
		[self SetLightingModel:YES];
	glPopMatrix();
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
	// end of opengl es code
}

//Iterates through all the markers and calls render on them
- (void) drawMarkers
{
	glPushMatrix();
	glEnableClientState(GL_VERTEX_ARRAY);
	
	for( int i = 0; i < totalCoordinates; i++ ){
		//Increment the offset like below to animate markers floating off the surface
		offset += 0.00095;
		if( offset >= 0.009 ) offset = 0.0;
		[markers[i] renderRotX: rotX rotY: rotY rotZ:0.0 zoom: zoomFactor offset: offset];
	}
	glPopMatrix();
}

- (void) loadTexture: (int)index Name: (NSString*) name{
    
    if (USE_PVR_TEXTURES && (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ||
                             ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)))
    {
        // The device is an iPad or Retina enabled iPhone or iPod Touch so you can use the larger texture
        name = [name stringByAppendingString:@"@2x"];
    }
    
    if(USE_PVR_TEXTURES){
        NSLog(@"Using PVR Textures");
        [self loadPVRTexture:index Name:name];
    }else{
        NSLog(@"Using PNG Textures");
        [self loadPNGTexture:index Name:name];
    }
}

// The name of a PVR texture and valid reference integer
// Creates a texture that can be bound to any openGL mesh
- (void) loadPVRTexture: (int)index Name: (NSString*) name{
	NSLog(@"BEGIN: loadTextureNumber");
	
	GLsizei width;
	GLsizei height;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ||
		([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)){
		// The device is an iPad or Retina enabled iPhone or iPod Touch
		width = 1024;
		height = 1024;
		//name = [name stringByAppendingString:@"-iPad"];
	}else 
	{
		// The device is an iPhone or iPod Touch
		width = 1024;
		height = 1024;
		//name = [name stringByAppendingString:@"-iPhone"];
	}
	
	glGenTextures(1, m_texture[index]);
	glBindTexture(GL_TEXTURE_2D, m_texture[index][0]);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	
	NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"pvr4"];
	NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
	
	
	glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG, width, height, 0, (width * height) / 2, [texData bytes]);
	
	[texData release];
	
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR); 
	glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR); 
	
}

// The name of a PNG image and valid reference integer
// Creates a texture that can be bound to any openGL mesh
- (void) loadPNGTexture: (int)index Name: (NSString*) name{
    CGImageRef imageRef = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",name]].CGImage;
    
	
	GLsizei width = CGImageGetWidth(imageRef);
	GLsizei height = CGImageGetHeight(imageRef);
	GLubyte * data = malloc(width * 4 * height);
	if (!data)
		NSLog(@"error allocating memory for texture loading!");
	else {
		NSLog(@"Memory allocated for %@", name);
	}
    
	CGContextRef cg_context = CGBitmapContextCreate(data, width, height, 8, 4 * width, CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(cg_context, 0, height);
	CGContextScaleCTM(cg_context, 1, -1);
	CGContextDrawImage(cg_context, CGRectMake(0, 0, width, height), imageRef);
	CGContextRelease(cg_context);
	
	glGenTextures(2, m_texture[index]);
	glBindTexture(GL_TEXTURE_2D, m_texture[index][0]);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	free(data);
	
}

//Destructor
- (void)dealloc {
    [smoothRotator release];
    [delegate release];
    [popUpViewController release];
    // [popoverController release];
    [self stopAnimation];
    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [context release];  
    [super dealloc];
}

//--------------------------------------------------- OPENGL ----------
//The remaining function help with openGL animation
- (void)layoutSubviews {
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
    [self drawView];
}

- (BOOL)createFramebuffer {
    
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    if (USE_DEPTH_BUFFER) {
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    }
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}


- (void)destroyFramebuffer {
    
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}


- (void)startAnimation {
	NSLog(@"got here startAnimation");
	self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(drawView) userInfo:nil repeats:YES];
}



- (void)stopAnimation {     self.animationTimer = nil; }   
- (void)setAnimationTimer:(NSTimer *)newTimer {     [animationTimer invalidate];     animationTimer = newTimer; }  
- (void)setAnimationInterval:(NSTimeInterval)interval {          animationInterval = interval;     if (animationTimer) {         [self stopAnimation];         [self startAnimation];     } } 


//For Demo Globe

-(IBAction)rotateConrolAction:(id)sender{
	NSLog(@"BEGIN: rotateConrolAction");
	//rotateOn = YES;
	//looking = YES;
    
	[self getAsingleMarker];
	[self lookAtMarker:theCurrentMarker];
}

-(IBAction)lightControlAction:(id)sender{
    lightOn = !lightOn;
    [self SetLightingModel:lightOn];
}

-(IBAction)markerControlAction:(id)sender{
	showMarkers = !showMarkers;
    
    if(showMarkers)
        touchBehavior = touchingMarker;
    else
        touchBehavior = gpsCoordinates;
}

-(IBAction)mapStateControlAction:(id)sender{
	NSLog(@"mapStateControlAction pushed");
	mapSwapState++;
    if (mapSwapState > 3) {
        mapSwapState = 0;
    }
	
	//MapSwapState mapSwapState;
    switch (mapSwapState) {
        case 0:
            lightOn = YES;
            [self loadTexture: 1 Name: @"PlainGlobe_Left"];
            [self loadTexture: 2 Name: @"PlainGlobe_Right"];
            break;
        case 1:
            lightOn = YES;
            [self loadTexture: 1 Name: @"PlainGlobe_Left"];
            [self loadTexture: 2 Name: @"PlainGlobe_Right"];
            break;
        case 2:
            lightOn = YES;
            [self loadTexture: 1 Name: @"GeoPolitical_Left"];
            [self loadTexture: 2 Name: @"GeoPolitical_Right"];
            break;
        case 3:
 			lightOn = NO;
            [self loadTexture: 1 Name: @"NightTimeGlobe_Left"];
            [self loadTexture: 2 Name: @"NightTimeGlobe_Right"];
            break;
        default:
            break;
    }
	[self SetLightingModel:lightOn];
}

-(IBAction)curLocationButtonAction:(id)sender{
	NSLog(@"curLocationButtonAction pushed");
	if(usersLocationMarker.location != nil)
		[self lookAtMarker:usersLocationMarker];
	else
		NSLog(@"no lat and lon");
}

// Called when the location is updated
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    
	
	usersLat = newLocation.coordinate.latitude;
	usersLon = newLocation.coordinate.longitude;
	
	CLLocation  *tempLocation = [[CLLocation alloc] initWithLatitude:usersLat longitude:usersLon];
	
	usersLocationMarker.location = tempLocation;
	
	//NSString *lat;
	//NSString *lon;
	//lat = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
	//lon = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    NSLog(@"Marker list count = %d", [theMarkerList.theList count]);
	int i;
	GlobeMarker *aTempMarker;
	
	//This loop addes the markers to the globe list
	for( i = 0; i < [theMarkerList.theList count];i++)
	{
		aTempMarker = [theMarkerList.theList objectAtIndex:i];
		
		//This line creates the marker
		[self addGlobeMarker:aTempMarker];
	}
	theClosestMarker = nil;
    
	NSLog(@"Got here :: didUpdateToLocation");
	[manager stopUpdatingLocation];
	
}


// Called when there is an error getting the location
- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"loc manager didFailWithError");
	NSMutableString *errorString = [[[NSMutableString alloc] init] autorelease];
	
	if ([error domain] == kCLErrorDomain) {
		
		// We handle CoreLocation-related errors here
		
		switch ([error code]) {
				// This error code is usually returned whenever user taps "Don't Allow" in response to
				// being told your app wants to access the current location. Once this happens, you cannot
				// attempt to get the location again until the app has quit and relaunched.
				//
				// "Don't Allow" on two successive app launches is the same as saying "never allow". The user
				// can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
				//
			case kCLErrorDenied:
				[errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationDenied", nil)];
				break;
				
				// This error code is usually returned whenever the device has no data or WiFi connectivity,
				// or when the location cannot be determined for some other reason.
				//
				// CoreLocation will keep trying, so you can keep waiting, or prompt the user.
				//
			case kCLErrorLocationUnknown:
				[errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationUnknown", nil)];
				break;
				
				// We shouldn't ever get an unknown error code, but just in case...
				//
			default:
				[errorString appendFormat:@"%@ %d\n", NSLocalizedString(@"GenericLocationError", nil), [error code]];
				break;
		}
	} else {
		// We handle all non-CoreLocation errors here
		// (we depend on localizedDescription for localization)
		[errorString appendFormat:@"Error domain: \"%@\"  Error code: %d\n", [error domain], [error code]];
		[errorString appendFormat:@"Description: \"%@\"\n", [error localizedDescription]];
	}
	
	NSLog(@"Error in LM = %@", errorString);
	//[self addTextToLog:errorString];
	// Send the update to our delegate
	//[self.delegate newLocationUpdate:errorString];
	
	[locationManager stopUpdatingLocation];
}

#pragma mark Begin MKReverseGeocoderDelegate methods
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
    NSLog(@"MKReverseGeocoder has failed. %@", [error localizedDescription]);
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
    NSLog(@"MKReverseGeocoder worked.");
	//thePlacemark = placemark;
	NSString *thoroughfare          = (placemark.thoroughfare          == nil) ? @"" : placemark.thoroughfare;
	NSString *subThoroughfare       = (placemark.subThoroughfare       == nil) ? @"" : placemark.subThoroughfare;
	NSString *locality              = (placemark.locality              == nil) ? @"" : placemark.locality;
	NSString *subLocality           = (placemark.subLocality           == nil) ? @"" : placemark.subLocality;
	NSString *administrativeArea    = (placemark.administrativeArea    == nil) ? @"" : placemark.administrativeArea;
	NSString *subAdministrativeArea = (placemark.subAdministrativeArea == nil) ? @"" : placemark.subAdministrativeArea;
	NSString *postalCode            = (placemark.postalCode            == nil) ? @"" : placemark.postalCode;
	NSString *country               = (placemark.country               == nil) ? @"" : placemark.country;
	NSString *countryCode           = (placemark.countryCode           == nil) ? @"" : placemark.countryCode;
	
	NSLog(@"   : %@",thoroughfare);
	NSLog(@"   : %@",subThoroughfare);
	NSLog(@"   : %@",locality);
	NSLog(@"   : %@",subLocality);
	NSLog(@"   : %@",administrativeArea);
	NSLog(@"   : %@",subAdministrativeArea);
	NSLog(@"   : %@",postalCode);
	NSLog(@"   : %@",country);
	NSLog(@"   : %@",countryCode);
	[self showMarkerOnGoogleMaps:placemark];
	
}
#pragma mark End MKReverseGeocoderDelegate methods

- (void)reverseGeocodeLocation:(CLLocation*)theLocation{
	NSLog(@"BEGIN: reverseGeocodeLocation;");
	//NSLog(@"     : lat = %f :: lon = %f",theLocation.coordinate.latitude, theLocation.coordinate.longitude);
	if (reverseGeocoder) {
		[reverseGeocoder release];
		reverseGeocoder = nil;
	}
	
    reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:theLocation.coordinate];
    reverseGeocoder.delegate = self;
    [reverseGeocoder start];
	NSLog(@"END: reverseGeocodeLocation;");
}

- (void) showMarkerOnGoogleMaps:(MKPlacemark*)thePlace{
	NSLog(@"BEGIN: showMarkerOnGoogleMaps");
	
	MapViewController *mapViewController = [[MapViewController alloc] initWithPlaceMark:thePlace loc:touchedLocation];
	mapViewController.hidesBottomBarWhenPushed = YES;
	[parentVC.navigationController pushViewController:mapViewController animated:YES];
	[mapViewController release];
}

-(IBAction)showGoogleMaps:(id)sender{
	NSLog(@"BEGIN: showGoogleMaps");
}

- (void)showPopupWindow:(GlobeMarker*)thePlace{
	//create the view controller from nib
    /*	self.popUpViewController = [[[PopupViewController alloc] 
     initWithNibName:@"ViewWithPicker" 
     bundle:[NSBundle mainBundle]] autorelease];
     
     self.popUpViewController._delegate = self; 
     
     //set popover content size
     popUpViewController.contentSizeForViewInPopover = 
     CGSizeMake(popUpViewController.view.frame.size.width, popUpViewController.view.frame.size.height);
     
     //set delegate 
     
     
     //create a popover controller
     self.popoverController = [[[UIPopoverController alloc]
     initWithContentViewController:popUpViewController] autorelease];
     
     //present the popover view non-modal with a
     //refrence to the button pressed within the current view
     [self.popoverController presentPopoverFromRect:CGRectMake(510.0f, 340.f, 10.0f, 10.0f) inView:self 
     permittedArrowDirections:0
     animated:YES];
     */
    
    [self.delegate launchPopupFromGlobe];
}

- (void) closePopupWindow{
    [self.popoverController dismissPopoverAnimated:YES];
}




@end
