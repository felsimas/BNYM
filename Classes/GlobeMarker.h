//  Copyright 2011 Logic Diner. All rights reserved.


#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

//------------------------------------------------------------------------------------------------
//
//These factors setup marks that can be "touchable"
//the texture currently used is Mark.png.

//this factor pulls the billboard-syle mark out from the globe
#define kSeparationFromGlobeFactor 0.1
//the marks are currently of relatvie dimension 2x1.  And are sized accordingly
#define kiPadMarkerSize 0.060
#define kiPhoneMarkerSize 0.110
//if you want custom dimension billboard, you will need to set the "bounds" for the mark in  GlobeMarker.m
//
#define IGNORE_MARKS_BEHIND_THIS_DEPTH -1.6	//anything below 0 is technically "behind" the globe, but with big markers, their corners could still show.  Setting this to -3.53 would allow all markers to be touched, even if unseen.  A value of 3.53 for depth would be right at the very closest point of the globe.

//------------------------------------------------------------------------------------------------



#define TOUCHING_MARKER_PROJECTIONS 1
//Enumerate graphical effects for GlobeMarkers
typedef enum {
	glow = 0,
	pin,
	twitter,
	bubble
} GlobeMarkerRenderEffect;

@interface GlobeMarker : NSObject{
@private
	GLfloat locationsVertices[3];
	GLuint locationsVertexCount;
	GLushort locationsIndices[3];
	GLuint locationsIndexCount;
	GLuint locationsNumVertices;
	float BoxRadius;
    
	BOOL drawPoint;
	CGRect bounds;
	
@public
	
    
	//used for calculating marker touches.  These are the upper left and lower right of the bounding box, in modelview coords.
	float x1, y1, x2, y2;
	
	float transX, transY, transZ;
	float rotX, rotY, rotZ;
	float scaleX, scaleY;
	GlobeMarkerRenderEffect currentEffect;
	CLLocation  *location;
	MKPlacemark *mapKitMarker;
	NSString    *locationDetails;
	CGRect projectionBox;
	float zSort;
}

#ifdef TOUCHING_MARKER_PROJECTIONS
@property (nonatomic, assign) CGRect projectionBox;
@property (nonatomic, assign)float zSort;
#endif

@property (nonatomic,retain) CLLocation  *location;
@property (nonatomic,assign) MKPlacemark *mapKitMarker;
@property (nonatomic,assign) NSString    *locationDetails;

-(void)renderRotX: (float)xIn rotY: (float)yIn rotZ: (float)zIn offset: (float)offset;
-(void)renderRotX: (float)xIn rotY: (float)yIn rotZ: (float)zIn zoom: (float)zoom offset: (float) offset;

-(GlobeMarker*)initWithX: (float) xIn Y: (float) yIn Z: (float) xzIn;

-(void)setTransX: (float)transXIn transY: (float)transYIn transZ: (float)transZIn;

-(void)setTransX: (float)transXIn transY: (float)transYIn transZ: (float)transZIn
			rotX: (float)rotXIn rotY: (float)rotYIn rotZ: (float)rotZIn
		  scaleX: (float)scaleXIn scaleY: (float) scaleYIn;

-(BOOL)deltaTransX: (float)transXIn transY: (float)transYIn transZ: (float)transZIn
			  rotX: (float)rotXIn rotY: (float)rotYIn rotZ: (float)rotZIn
			scaleX: (float)scaleXIn scaleY: (float) scaleYIn;

-(BOOL)isMarkerBeingTouched:(float*)ray globeOffset:(float)globeOffset globeRotateX:(float)rotX globeRotateY:(float)rotY atDepth:(float*)depth;

@end
