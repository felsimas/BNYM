//  Copyright 2011 Logic Diner. All rights reserved.

#import "MarkersForGlobeList.h"


@implementation MarkersForGlobeList

@synthesize theList; //the list of markers

//When the object is intialized there will be a list of marker created
-(id) init
{
	theList = [[NSMutableArray alloc] init];
	[self generateTheList];
	
	return self;
}


//Function for adding a single marker to the 'list'
-(void)addGlobeMarker:(float)lat
         theLongitude:(float)lon
         locationName:(NSString *)locName
{
	aTempMarker = [[GlobeMarker alloc] init];
	CLLocation  *tempLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
	
	aTempMarker.location = tempLocation;
	aTempMarker.locationDetails  = locName;  //The marker's location
	
    //	float newlat = tempLocation.coordinate.latitude;
    //	float newlong = tempLocation.coordinate.longitude;
    //	NSLog(@"was %f, %f and is now %f, %f", lat, lon, newlat, newlong);
	//add the marker to the main list
	[theList addObject:aTempMarker];
	
	//Release the objects here
	[aTempMarker release];
	aTempMarker = nil;
}

-(void)generateTheList{
	//[self addGlobeMarker:  53.344104  theLongitude:   -6.267494  locationName:@"Ireland"];
	//[self addGlobeMarker:  51.481068  theLongitude:   -0.110152  locationName:@"England"];
	
	//[self addGlobeMarker:  53.480712  theLongitude:   -2.234376  locationName:@"England"];
	
	[self addGlobeMarker:  0.0  theLongitude:   0.0  locationName:@"zero"];
    //	[self addGlobeMarker:  45.0  theLongitude:   0.0  locationName:@"45 0"];
    //	[self addGlobeMarker:  45.0  theLongitude:   45.0  locationName:@"45 45"];
    //	[self addGlobeMarker:  45.0  theLongitude:   -45.0  locationName:@"45 -45"];
    //	[self addGlobeMarker:  0.0  theLongitude:   45.0  locationName:@"0 45"];
    //	[self addGlobeMarker:  0.0  theLongitude:   -45.0  locationName:@"0 -45"];
    //	
	
	[self addGlobeMarker:  52.523405  theLongitude:   13.411400  locationName:@"Germany"];
	[self addGlobeMarker:  47.655113  theLongitude:  -76.367183  locationName:@"Canada"];
	[self addGlobeMarker:  35.031859  theLongitude:  -97.052889  locationName:@"United States"];
	[self addGlobeMarker:  23.479369  theLongitude: -101.707280  locationName:@"Mexico"];
	[self addGlobeMarker:  38.950000  theLongitude:   77.460000  locationName:@"Washington,DC"];
	[self addGlobeMarker:  48.828083  theLongitude:    2.416992  locationName:@"Paris, France"];
	[self addGlobeMarker:  53.218752  theLongitude:   -6.240234  locationName:@"Dublin, Ireland"];
	[self addGlobeMarker:  53.086986  theLongitude:   -2.416992  locationName:@"Manchester, United Kingdom"];
	[self addGlobeMarker:  35.298240  theLongitude:  139.833984  locationName:@"Tokyo, Japan"];
	[self addGlobeMarker:  32.820000  theLongitude:  116.970000  locationName:@"San Diego,CA"];
	[self addGlobeMarker:  38.950000  theLongitude:   77.460000  locationName:@"Washington,DC"];
	[self addGlobeMarker:  48.828083  theLongitude:    2.416992  locationName:@"Paris, France"];
	[self addGlobeMarker:  53.086986  theLongitude:   -2.416992  locationName:@"Manchester, United Kingdom"];
	[self addGlobeMarker:  52.395269  theLongitude:   13.447266  locationName:@"Berlin, Germany"];
	[self addGlobeMarker:  41.860834  theLongitude:   12.436523  locationName:@"Rome, Italy"];
	[self addGlobeMarker:  40.304107  theLongitude:   -3.691406  locationName:@"Madrid, Spain"];
	[self addGlobeMarker: -30.089375  theLongitude:   31.113281  locationName:@"Durbin, South Africa"];
    
	//srandom();
	
	//for(int x = 0; x < 4500; x++){
	//	int random1 = random()%170;
	//	int random2 = random()%360;
	//	[self addGlobeMarker:  -89 + random1  theLongitude:   -189 + random2  locationName:@"Edinburgh, Scotland"];
	//}
	
}

//Destructor
- (void)dealloc {    
	[theList     release];   // list of markers for the globe
	[aTempMarker release];   // temporary variable used while generating the main list array
    [super       dealloc];
}

@end
