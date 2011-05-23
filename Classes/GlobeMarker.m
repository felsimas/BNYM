//  Copyright 2011 Logic Diner. All rights reserved.


#import "GlobeMarker.h"
#import "GlobeConstants.h"
#import "Textures.h"
#import <OpenGLES/ES1/glext.h>
#define kMaxTextureSize	 1024

@implementation GlobeMarker

@synthesize location;
@synthesize mapKitMarker;
@synthesize locationDetails;

#ifdef TOUCHING_MARKER_PROJECTIONS
@synthesize projectionBox;
@synthesize zSort;
#endif


-(CGRect)setRectFromRadius:(float)radius {
	CGRect newRect = CGRectMake(-radius, -radius/2, radius*2, radius);
	return newRect;
}
-(GlobeMarker*)initWithX: (float) xIn Y: (float) yIn Z: (float) zIn
{
	self = [super init];
	
	if( self ){
		BoxRadius = 0.275;
		bounds = [self setRectFromRadius:BoxRadius];
		transX = xIn;	transY = yIn;	transZ = zIn;
		drawPoint = NO;
		
		locationsVertices[0] = 0.0;
		locationsVertices[1] = 1.0;
		locationsVertices[2] = 0.0;
		
		locationsVertexCount = 1;
		locationsIndices[0] = 0;
		locationsIndices[1] = 1;
		locationsIndices[2] = 2;
		
		locationsIndexCount = 3;
		locationsNumVertices = 1;
        
		currentEffect = glow;
	}
	return self;
}

-(void)renderRotX: (float)xIn rotY: (float)yIn rotZ: (float)zIn zoom: (float)zoom offset: (float) offset
{
	//Zoom range is [-10, -6.5] -> [far, close]
	//Bounds raide is .075 @ -10
	//It needs to look the same size at -6.5
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ||
		([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)){
		// The device is an iPad or Retina enabled iPhone or iPod Touch
		offset += 1.002;
		BoxRadius = kiPadMarkerSize*zoom/10;
	}
	else
	{
		// The device is an iPhone or iPod touch.
		offset += 1.008;
		BoxRadius = kiPhoneMarkerSize*zoom/10;
	}
	bounds = [self setRectFromRadius:BoxRadius];
	
	[self renderRotX: xIn rotY: yIn rotZ: zIn offset: offset];
}
#define GLOBE_RADIUS2 2 + kSeparationFromGlobeFactor
-(BOOL)isMarkerBeingTouched:(float*)ray globeOffset:(float)globeOffset globeRotateX:(float)rX globeRotateY:(float)rY atDepth:(float *)depth {
	//ray is float ray[3]; and points from the point 0,0 to the point on the "frustum plane" we touched.
    
	//we extend that ray out to the z-depth of the marker, then compare our intersection point with the x andy bounds of the box (in matrixview coordinates)
	float rayScaleFactor = (-zSort)/ray[2];
	float xTouchAtZ = ray[0] * rayScaleFactor * 2;
	float yTouchAtZ = -ray[1] * rayScaleFactor * 2;
    //	NSLog(@"Touch x, y is %f, %f", xTouchAtZ, yTouchAtZ);
	
	if (!( xTouchAtZ < x1 && xTouchAtZ < x2) && !(xTouchAtZ > x1 && xTouchAtZ > x2)
		&& !(yTouchAtZ < y1 && yTouchAtZ < y2) && !(yTouchAtZ > y1 && yTouchAtZ > y2)) {
		*depth = zSort;
		return YES;
	}
	
	
	return NO;
}
-(void)renderRotX: (float)xIn rotY: (float)yIn rotZ: (float)zIn offset: (float)offset
{
	float scaleFactor = 1; 
	
	switch( currentEffect )
	{
		case glow:
			//Draw Glow
			glPushMatrix();
			glScalef(offset, offset, offset);
			
			glVertexPointer(3, GL_FLOAT, 0, locationsVertices);
			glTranslatef( transX, transY+1.0, transZ );
			glRotatef(xIn+90, 0.0f, 0.0f, 1.0f);
			glRotatef(yIn, 0.0f, 1.0f, 0.0f);
			glScalef(.75, .75, .75);
			float selectGlow = random() % 100;
			
			//Textures *commonAPI = [Textures global_textures];
			
			if( selectGlow < 50 )
				[[[Textures global_textures] glow1] drawInRect:bounds];
			else if( selectGlow < 96 )
				[[[Textures global_textures] glow2] drawInRect:bounds]; 
			else
				[[[Textures global_textures] glow3] drawInRect:bounds]; 
			glPopMatrix();
			break;
		case pin:
            //			NSLog(@"coords are %f, %f, %f", xIn, yIn, zIn);
			//Draw Pin Head
		{
			glPushMatrix();
			glTranslatef( transX, transY+1.0, transZ );
			//this translation will push the marker out away from the globe
			glTranslatef(kSeparationFromGlobeFactor* transX, kSeparationFromGlobeFactor* transY, kSeparationFromGlobeFactor* transZ );
			GLfloat result[16];
			glGetFloatv(GL_MODELVIEW_MATRIX, &result[0]);
			
            
			//These will rotate the marker to face the camera
			glRotatef(xIn+90, 0.0f, 0.0f, 1.0f);
			glRotatef(yIn, 0.0f, 1.0f, 0.0f);
			
			//this rotation will rotate the marker to orient to "read" properly if containing text.
			glRotatef(90, 0, 0, 1.0);
			
			
			//now we will pull off the values for the marker positions in modelview coordinates, saving the matrix along the way.
			GLfloat inMatrix[] = {bounds.origin.x, bounds.origin.y, 0, 1,
                0, 0, 0, 0,
                0, 0, 0, 0,
                0, 0, 0, 0};
			glPushMatrix();
			glMultMatrixf(&inMatrix[0]);
			glGetFloatv(GL_MODELVIEW_MATRIX, &result[0]);
			glPopMatrix();
			x1 = result[0];
			y1 = result[1];
			zSort = result[2];
            
			inMatrix[0] = bounds.origin.x + bounds.size.width;
			inMatrix[1] = bounds.origin.y + bounds.size.height;
			glPushMatrix();
			glMultMatrixf(&inMatrix[0]);
			glGetFloatv(GL_MODELVIEW_MATRIX, &result[0]);
			glPopMatrix();
			x2 = result[0];
			y2 = result[1];
            
			
            
			[[[Textures global_textures] mark] drawInRect:bounds];
            
			glPopMatrix();
			
			break;
		}
		case twitter:
			//Draw Twitter Bird
			glPushMatrix();
			glScalef(1.05+offset, 1.05+offset, 1.05+offset);
			
			glTranslatef( transX, transY+1.0, transZ );
			glRotatef(xIn+90, 0.0f, 0.0f, 1.0f);
			glRotatef(yIn, 0.0f, 1.0f, 0.0f);
			
			
			glScalef(scaleFactor, scaleFactor, scaleFactor);
			
			[[[Textures global_textures] twitter] drawInRect:bounds];
			
			glPopMatrix();
			break;
		case bubble:
			//Draw Twitter Bird
			glPushMatrix();
			glScalef(1.05+offset, 1.05+offset, 1.05+offset);
			
			glTranslatef( transX, transY+1.0, transZ );
			glRotatef(xIn+90, 0.0f, 0.0f, 1.0f);
			glRotatef(yIn, 0.0f, 1.0f, 0.0f);
			
			glScalef(scaleFactor, scaleFactor, scaleFactor);
			
			[[[Textures global_textures] bubble] drawInRect:bounds];
			
			glPopMatrix();
			break;
	}
}

-(void)setTransX: (float)transXIn transY: (float)transYIn transZ: (float)transZIn
{
	transX -= transXIn;	transY -= transYIn;	transZ -= transZIn;
}

-(void)setTransX: (float)transXIn transY: (float)transYIn transZ: (float)transZIn
			rotX: (float)rotXIn rotY: (float)rotYIn rotZ: (float)rotZIn
		  scaleX: (float)scaleXIn scaleY: (float)scaleYIn{
	
	transX = transXIn;	transY = transYIn;	transZ = transZIn;
	rotX = rotXIn;		rotY = rotYIn;		rotZ = rotZIn;
	scaleX = scaleXIn;	scaleY = scaleYIn;
	bounds = CGRectMake(-(scaleX)/2, -(scaleY)/2, scaleX, scaleY);
}

-(BOOL)deltaTransX: (float)transXIn transY: (float)transYIn transZ: (float)transZIn
			  rotX: (float)rotXIn rotY: (float)rotYIn rotZ: (float)rotZIn
			scaleX: (float)scaleXIn scaleY: (float) scaleYIn{
	
	transX -= transXIn;	transY -= transYIn;	transZ -= transZIn;
	rotX -= rotXIn;		rotY -= rotYIn;		rotZ -= rotZIn;
	if( scaleX >= 0.1 )
	{
		scaleX -= scaleXIn;	scaleY -= scaleYIn;
		bounds = CGRectMake(-(scaleX)/2, -(scaleY)/2, scaleX, scaleY);
		return NO;
	}else
	{
		return YES;
	}
}
@end

