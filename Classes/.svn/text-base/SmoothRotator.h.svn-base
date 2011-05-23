// Copyright 2009 Clever Coding LLC. All rights reserved.
//
// SmoothRotator class is a convience class used to calculate the direct point between two points on the globe
//


#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>

typedef float Vector3[3];

@interface SmoothRotator : NSObject {

	float startLat;
	float startLon;
	Vector3 startPos;
	Vector3 endPos;
	
	Vector3 axis;
	float angularDistance;
	
	float rotX;
	float rotY;
	
	float angularSpeed;
	NSUInteger numSteps;
	NSUInteger currentStep;
}

@property (readonly) NSUInteger numSteps;
@property (readonly) NSUInteger currentStep;
@property (readonly) float rotX;
@property (readonly) float rotY;
@property (readonly) float angularDistance;

/**
 * Initialize a new rotation from the given latitude and longitude to the given point, using the given angular
 * step size speed. This method does preliminary calculations and sets instance variables needed to calculate the
 * steps (using stepRotation).
 */
- (void) newRotationFromLat: (float) lat andLon: (float) lon toPoint: (Vector3) dest withAngularSpeed: (float) angSpeed;

/**
 * This method does the actual rotation step. After running this method, use the rotX and rotY properties to get the
 * current rotation. When the last step has completed, this method returns YES. At every other step, it returns NO.
 */
- (BOOL) stepRotation;

@end
