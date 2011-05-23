//  Copyright 2009 Clever Coding LLC. All rights reserved.
//  Texture2D.h is mostly borrowed from Apple example code
//     it was put in this class to make the code more managable
//
//  GlobeMarker.h handles all the rendering for the markers




//
//  Face.h
//  globe
//
//  Copyright 2009 Clever Coding LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

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
	

	float transX, transY, transZ;
	float rotX, rotY, rotZ;
	float scaleX, scaleY;
	GlobeMarkerRenderEffect currentEffect;
	CLLocation  *location;
	MKPlacemark *mapKitMarker;
	NSString    *locationDetails;
}


@property (nonatomic,assign) CLLocation  *location;
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
@end
