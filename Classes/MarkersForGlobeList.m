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
	
	[self addGlobeMarker:  52.229676  theLongitude:   21.012229  locationName:@"Poland"];
	[self addGlobeMarker:  52.523405  theLongitude:   13.411400  locationName:@"Germany"];
	[self addGlobeMarker:  35.689488  theLongitude:  139.691706  locationName:@"Japan"];
	[self addGlobeMarker: -37.814251  theLongitude:  144.963169  locationName:@"Austrila"];
	[self addGlobeMarker:  59.794739  theLongitude:   10.766602  locationName:@"Norway"];
	[self addGlobeMarker:  47.449885  theLongitude:   18.984375  locationName:@"Hungary"];
	[self addGlobeMarker:  41.860834  theLongitude:   12.436523  locationName:@"Italy"];
	[self addGlobeMarker:  40.304107  theLongitude:   -3.691406  locationName:@"Spain"];
	[self addGlobeMarker:  38.539000  theLongitude:   -9.228516  locationName:@"Portugal"];
	[self addGlobeMarker:  29.716045  theLongitude:   31.201172  locationName:@"Egypt"];
	[self addGlobeMarker:  33.265025  theLongitude:   44.296875  locationName:@"Iraq"];
	[self addGlobeMarker:  28.515683  theLongitude:   77.343750  locationName:@"India"];
	[self addGlobeMarker:  37.001383  theLongitude:  127.265625  locationName:@"Korea"];
	[self addGlobeMarker: -27.859799  theLongitude:  153.105469  locationName:@"Austrila"];
	[self addGlobeMarker: -33.922461  theLongitude:   18.416619  locationName:@"South Africa"];
	[self addGlobeMarker:   -.228021  theLongitude:   15.827659  locationName:@"Congo"];
	[self addGlobeMarker: -19.330978  theLongitude:   46.776047  locationName:@"Madagascar"];
	[self addGlobeMarker:  14.350330  theLongitude:   29.062629  locationName:@"Sudan"];
	[self addGlobeMarker:  23.417277  theLongitude:   44.778280  locationName:@"Saudi Arabia"];
	[self addGlobeMarker:  31.768319  theLongitude:   35.213710  locationName:@"Israel"];
	[self addGlobeMarker:  38.957323  theLongitude:   34.217424  locationName:@"Turkey"];
	[self addGlobeMarker:  50.276689  theLongitude:   32.327879  locationName:@"Ukraine"];
	[self addGlobeMarker:  55.803982  theLongitude:   41.761234  locationName:@"Russia"];
	[self addGlobeMarker:  46.215393  theLongitude:  102.854523  locationName:@"Mongolia"];
	[self addGlobeMarker:  47.655113  theLongitude:  -76.367183  locationName:@"Canada"];
	[self addGlobeMarker:  35.031859  theLongitude:  -97.052889  locationName:@"United States"];
	[self addGlobeMarker:  23.479369  theLongitude: -101.707280  locationName:@"Mexico"];
	[self addGlobeMarker:   8.556493  theLongitude:  -81.407045  locationName:@"Panama"];
	[self addGlobeMarker:   7.286046  theLongitude:  -65.128901  locationName:@"Venezuel"];
	[self addGlobeMarker:  12.441051  theLongitude:  -69.972183  locationName:@"Aruba"];
	[self addGlobeMarker:   5.836170  theLongitude:  -59.017716  locationName:@"Guyana"];
	[self addGlobeMarker: -10.331031  theLongitude:  -51.579886  locationName:@"Brazil"];
	[self addGlobeMarker: -37.464713  theLongitude:  -65.286900  locationName:@"Argentina"];
	[self addGlobeMarker: -32.519997  theLongitude:  -55.888399  locationName:@"Uruguay"];
	[self addGlobeMarker:  45.524000  theLongitude:  123.366000  locationName:@"Portland, OR"];
	[self addGlobeMarker:  48.800000  theLongitude:    2.500000  locationName:@"Paris, France"];
	[self addGlobeMarker:  48.800000  theLongitude:    2.500000  locationName:@"Philomath, OR"];
	[self addGlobeMarker:  34.830000  theLongitude:   92.250000  locationName:@"Little Rock,AR"];
	[self addGlobeMarker:  35.430000  theLongitude:  119.050000  locationName:@"Bakersfield,CA"];
	[self addGlobeMarker:  33.300000  theLongitude:  117.350000  locationName:@"Camp Pendlet,CA"];
	[self addGlobeMarker:  39.780000  theLongitude:  121.850000  locationName:@"Chico,CA"];
	[self addGlobeMarker:  36.770000  theLongitude:  119.720000  locationName:@"Fresno,CA"];
	[self addGlobeMarker:  33.870000  theLongitude:  117.970000  locationName:@"Fullerton,CA"];
	[self addGlobeMarker:  38.900000  theLongitude:  120.000000  locationName:@"Lake Tahoe,CA"];
	[self addGlobeMarker:  33.820000  theLongitude:  118.150000  locationName:@"Long Beach,CA"];
	[self addGlobeMarker:  32.730000  theLongitude:  117.170000  locationName:@"San Diego,CA"];
	[self addGlobeMarker:  32.570000  theLongitude:  116.980000  locationName:@"San Diego,CA"];
	[self addGlobeMarker:  32.820000  theLongitude:  116.970000  locationName:@"San Diego,CA"];
	[self addGlobeMarker:  37.620000  theLongitude:  122.380000  locationName:@"San Francisco,CA"];
	[self addGlobeMarker:  37.370000  theLongitude:  121.920000  locationName:@"San Jose,CA"];
	[self addGlobeMarker:  35.230000  theLongitude:  120.650000  locationName:@"San Luis Obi,CA"];
	[self addGlobeMarker:  34.430000  theLongitude:  119.830000  locationName:@"Santa Barb,CA"];
	[self addGlobeMarker:  40.000000  theLongitude:  105.870000  locationName:@"Winter Park,CO"];
	[self addGlobeMarker:  41.730000  theLongitude:   72.650000  locationName:@"Hartford,CT"];
	[self addGlobeMarker:  39.130000  theLongitude:   75.470000  locationName:@"Dover,DE"];
	[self addGlobeMarker:  38.950000  theLongitude:   77.460000  locationName:@"Washington,DC"];
	[self addGlobeMarker:  28.470000  theLongitude:   80.550000  locationName:@"Cape Canaveral,FL"];
	[self addGlobeMarker:  48.828083  theLongitude:    2.416992  locationName:@"Paris, France"];
	[self addGlobeMarker:  53.218752  theLongitude:   -6.240234  locationName:@"Dublin, Ireland"];
	[self addGlobeMarker:  53.086986  theLongitude:   -2.416992  locationName:@"Manchester, United Kingdom"];
	[self addGlobeMarker:  52.153265  theLongitude:   21.005859  locationName:@"Warsaw, Poland"];
	[self addGlobeMarker:  52.395269  theLongitude:   13.447266  locationName:@"Berlin, Germany"];
	[self addGlobeMarker:  59.794739  theLongitude:   10.766602  locationName:@"Oslo, Norway"];
	[self addGlobeMarker:  47.449885  theLongitude:   18.984375  locationName:@"Budapest, Slovakia"];
	[self addGlobeMarker:  41.860834  theLongitude:   12.436523  locationName:@"Rome, Italy"];
	[self addGlobeMarker:  40.304107  theLongitude:   -3.691406  locationName:@"Madrid, Spain"];
	[self addGlobeMarker:  38.539000  theLongitude:   -9.228516  locationName:@"Lisbon, Portugal"];
	[self addGlobeMarker:  29.716045  theLongitude:   31.201172  locationName:@"Cairo, Egypt"];
	[self addGlobeMarker:  33.265025  theLongitude:   44.296875  locationName:@"Baghdad, Iraq"];
	[self addGlobeMarker:  28.515683  theLongitude:   77.343750  locationName:@"New Delhi, India"];
	[self addGlobeMarker:  37.001383  theLongitude:  127.265625  locationName:@"Seoul, South Korea"];
	[self addGlobeMarker:  35.298240  theLongitude:  139.833984  locationName:@"Tokyo, Japan"];
	[self addGlobeMarker:   1.119070  theLongitude:  104.150391  locationName:@"Singapore, Malaysia"];
	[self addGlobeMarker: -27.859799  theLongitude:  153.105469  locationName:@"Brisbane, Australia"];
	[self addGlobeMarker: -38.222070  theLongitude:  144.755859  locationName:@"Melbourne, Australia"];
	[self addGlobeMarker: -34.108469  theLongitude:  151.523438  locationName:@"Sydney, Australia"];
	[self addGlobeMarker: -10.165002  theLongitude:  147.304688  locationName:@"Port Moresby, Papua New Guinea"];
	[self addGlobeMarker: -30.089375  theLongitude:   31.113281  locationName:@"Durbin, South Africa"];
	[self addGlobeMarker: -34.108469  theLongitude:   18.808594  locationName:@"Cape Town, South Africa"];
	[self addGlobeMarker:  55.763389  theLongitude:   -2.812500  locationName:@"Edinburgh, Scotland"];
	[self addGlobeMarker:  45.524000  theLongitude:  123.366000  locationName:@"Portland, OR"];
	[self addGlobeMarker:  48.800000  theLongitude:    2.500000  locationName:@"Paris, France"];
	[self addGlobeMarker:  48.800000  theLongitude:    2.500000  locationName:@"Philomath, OR"];
	[self addGlobeMarker:  34.830000  theLongitude:   92.250000  locationName:@"Little Rock,AR"];
	[self addGlobeMarker:  35.430000  theLongitude:  119.050000  locationName:@"Bakersfield,CA"];
	[self addGlobeMarker:  33.300000  theLongitude:  117.350000  locationName:@"Camp Pendlet,CA"];
	[self addGlobeMarker:  39.780000  theLongitude:  121.850000  locationName:@"Chico,CA"];
	[self addGlobeMarker:  36.770000  theLongitude:  119.720000  locationName:@"Fresno,CA"];
	[self addGlobeMarker:  33.870000  theLongitude:  117.970000  locationName:@"Fullerton,CA"];
	[self addGlobeMarker:  38.900000  theLongitude:  120.000000  locationName:@"Lake Tahoe,CA"];
	[self addGlobeMarker:  33.820000  theLongitude:  118.150000  locationName:@"Long Beach,CA"];
	[self addGlobeMarker:  32.730000  theLongitude:  117.170000  locationName:@"San Diego,CA"];
	[self addGlobeMarker:  32.570000  theLongitude:  116.980000  locationName:@"San Diego,CA"];
	[self addGlobeMarker:  32.820000  theLongitude:  116.970000  locationName:@"San Diego,CA"];
	[self addGlobeMarker:  37.620000  theLongitude:  122.380000  locationName:@"San Francisco,CA"];
	[self addGlobeMarker:  37.370000  theLongitude:  121.920000  locationName:@"San Jose,CA"];
	[self addGlobeMarker:  35.230000  theLongitude:  120.650000  locationName:@"San Luis Obi,CA"];
	[self addGlobeMarker:  34.430000  theLongitude:  119.830000  locationName:@"Santa Barb,CA"];
	[self addGlobeMarker:  40.000000  theLongitude:  105.870000  locationName:@"Winter Park,CO"];
	[self addGlobeMarker:  41.730000  theLongitude:   72.650000  locationName:@"Hartford,CT"];
	[self addGlobeMarker:  39.130000  theLongitude:   75.470000  locationName:@"Dover,DE"];
	[self addGlobeMarker:  38.950000  theLongitude:   77.460000  locationName:@"Washington,DC"];
	[self addGlobeMarker:  28.470000  theLongitude:   80.550000  locationName:@"Cape Canaveral,FL"];
	[self addGlobeMarker:  48.828083  theLongitude:    2.416992  locationName:@"Paris, France"];
	[self addGlobeMarker:  53.218752  theLongitude:   -6.240234  locationName:@"Dublin, Ireland"];
	[self addGlobeMarker:  53.086986  theLongitude:   -2.416992  locationName:@"Manchester, United Kingdom"];
	[self addGlobeMarker:  52.153265  theLongitude:   21.005859  locationName:@"Warsaw, Poland"];
	[self addGlobeMarker:  52.395269  theLongitude:   13.447266  locationName:@"Berlin, Germany"];
	[self addGlobeMarker:  59.794739  theLongitude:   10.766602  locationName:@"Oslo, Norway"];
	[self addGlobeMarker:  47.449885  theLongitude:   18.984375  locationName:@"Budapest, Slovakia"];
	[self addGlobeMarker:  41.860834  theLongitude:   12.436523  locationName:@"Rome, Italy"];
	[self addGlobeMarker:  40.304107  theLongitude:   -3.691406  locationName:@"Madrid, Spain"];
	[self addGlobeMarker:  38.539000  theLongitude:   -9.228516  locationName:@"Lisbon, Portugal"];
	[self addGlobeMarker:  29.716045  theLongitude:   31.201172  locationName:@"Cairo, Egypt"];
	[self addGlobeMarker:  33.265025  theLongitude:   44.296875  locationName:@"Baghdad, Iraq"];
	[self addGlobeMarker:  28.515683  theLongitude:   77.343750  locationName:@"New Delhi, India"];
	[self addGlobeMarker:  37.001383  theLongitude:  127.265625  locationName:@"Seoul, South Korea"];
	[self addGlobeMarker:  35.298240  theLongitude:  139.833984  locationName:@"Tokyo, Japan"];
	[self addGlobeMarker:   1.119070  theLongitude:  104.150391  locationName:@"Singapore, Malaysia"];
	[self addGlobeMarker: -27.859799  theLongitude:  153.105469  locationName:@"Brisbane, Australia"];
	[self addGlobeMarker: -38.222070  theLongitude:  144.755859  locationName:@"Melbourne, Australia"];
	[self addGlobeMarker: -34.108469  theLongitude:  151.523438  locationName:@"Sydney, Australia"];
	[self addGlobeMarker: -10.165002  theLongitude:  147.304688  locationName:@"Port Moresby, Papua New Guinea"];
	[self addGlobeMarker: -30.089375  theLongitude:   31.113281  locationName:@"Durbin, South Africa"];
	[self addGlobeMarker: -34.108469  theLongitude:   18.808594  locationName:@"Cape Town, South Africa"];
	[self addGlobeMarker:  55.763389  theLongitude:   -2.812500  locationName:@"Edinburgh, Scotland"];
    
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
