// Copyright 2009 Clever Coding LLC. All rights reserved.
//
// SmoothRotator class is a convenience  class used to calculate the direct point between two points on the globe
//

#import "SmoothRotator.h"

@implementation SmoothRotator

@synthesize numSteps;
@synthesize currentStep;
@synthesize rotX;
@synthesize rotY;
@synthesize angularDistance;


/**
 * Initialize a new rotation from the given latitude and longitude to the given point, using the given angular
 * step size speed. This method does preliminary calculations and sets instance variables needed to calculate the
 * steps (using stepRotation).
 */
- (void) newRotationFromLat: (float) lat andLon: (float) lon toPoint: (Vector3) dest withAngularSpeed: (float) angSpeed {

	// save starting latitude/longitude (in degrees, adusted (not user lat/lon))
	startLat = lat;
	startLon = lon;

	// save starting position (based on starting lat/lon)
	float lat_rad = (lat * M_PI)/180;
	float lon_rad = (lon * M_PI)/180;	
	startPos[0] = cos(lon_rad) * sin(lat_rad);
	startPos[1] = sin(lon_rad) * sin(lat_rad);
	startPos[2] = cos(lat_rad);
	
	// save ending position (and adjust rotation)
	float atheta = -90 * M_PI/180;
	endPos[0] = dest[0] * cosf(atheta) - dest[1] * sinf(atheta);
	endPos[1] = dest[0] * sinf(atheta) + dest[1] * cosf(atheta);
	endPos[2] = dest[2];
	
	// save angular speed
	angularSpeed = angSpeed;
	
	// find axis to rotate about using a cross product of startPos and endPos
	axis[0] = startPos[1] * endPos[2] - startPos[2] * endPos[1];
	axis[1] = -startPos[0] * endPos[2] + startPos[2] * endPos[0];
	axis[2] = startPos[0] * endPos[1] - startPos[1] * endPos[0];

	// just in case we try to rotate from/to a single point;
	// the axis wouldn't matter in this case, be it still must be a unit vector, so set axis[0] = 1
	if (axis[0] == 0 && axis[1] == 0 && axis[2] == 0)
		axis[0] = 1;
	// normalize this vector just in case it wasn't normalized already
	float mag = sqrt(axis[0] * axis[0] + axis[1] * axis[1] + axis[2] * axis[2]);
	axis[0] = axis[0] / mag;
	axis[1] = axis[1] / mag;
	axis[2] = axis[2] / mag;
	
	// find the angular distance of the desired rotation using dot product of startPos and endPos
	float dot = startPos[0] * endPos[0] + startPos[1] * endPos[1] + startPos[2] * endPos[2];
	angularDistance = acos(dot) * 180 / M_PI;
	
	// determine the number of steps that will be needed to complete the rotation at the desired speed
	numSteps = (int) (angularDistance / angularSpeed);
	if (numSteps == 0)
		numSteps = 1;
	
	// initialize currentStep
	currentStep = 0;
}

/**
 * This method does the actual rotation step. After running this method, use the rotX and rotY properties to get the
 * current rotation. When the last step has completed, this method returns YES. At every other step, it returns NO.
 */
- (BOOL) stepRotation {
	float currentAngle = (float) currentStep * angularDistance / numSteps;
	float theta = currentAngle * M_PI / 180;

	// find current x,y,z
	float c = cos(-theta);
	float s = sin(-theta);
	float t = (1 - c);
	float tx_2c = t * axis[0] * axis[0] + c;
	float ty_2c = t * axis[1] * axis[1] + c;
	float tz_2c = t * axis[2] * axis[2] + c;
	float txy = t * axis[0] * axis[1];
	float txz = t * axis[0] * axis[2];
	float tyz = t * axis[1] * axis[2];
	float sz = s * axis[2];
	float sx = s * axis[0];
	float sy = s * axis[1];
	
	float x = startPos[0] * tx_2c + startPos[1] * (txy + sz) + startPos[2] * (txz - sy);
	float y = startPos[0] * (txy - sz) + startPos[1] * ty_2c + startPos[2] * (tyz + sx);
	float z = startPos[0] * (txz + sy) + startPos[1] * (tyz - sx) + startPos[2] * (tz_2c);
	
	// convert to spherical coordinates
	float xRot = atan2f(y, x) * 180 / M_PI;
	float yRot = acosf(z/sqrt(x*x + y*y + z*z)) * 180 / M_PI;

	// set properties for use in drawView
	rotX = xRot;
	rotY = yRot;
	
	currentStep++;
	if (currentStep == numSteps)
		return YES;
	else
		return NO;
}

@end
