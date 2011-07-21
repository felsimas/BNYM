//  Copyright 2011 Logic Diner. All rights reserved.

#import "MarkersForGlobeList.h"
#import <SBJson/SBJson.h>


@implementation MarkersForGlobeList

@synthesize theList; //the list of markers


//When the object is intialized there will be a list of marker created
-(id) init
{
	theList = [[NSMutableArray alloc] init];
	[self generateTheList];
	return self;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
    
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
    
    NSLog(responseString);
    
    NSDictionary *dictionary = [responseString JSONValue];
    NSInteger total = [dictionary count];
    NSInteger ix;
    
    NSLog(@"contador: %d",total);
    
    for( ix = 1; ix <= total;ix++)
	{
        NSString *stri;
        stri = [NSString stringWithFormat:@"%d",ix];
 
        NSDictionary *users = [dictionary objectForKey: stri];
        NSString *latitudefile;
        NSString *longitudefile;
        NSString *location;
        NSString *country;
        country = [users objectForKey:@"country"];
        location = [users objectForKey:@"location"];
        latitudefile = [users objectForKey:@"latitude"];
        longitudefile = [users objectForKey:@"longitude"];
    
        NSLog(@"latitude: %@",latitudefile);
        NSLog(@"longitude: %@",longitudefile);
    
        longitudefile = [longitudefile stringByReplacingOccurrencesOfString:@"'" withString:@""];
        longitudefile = [longitudefile stringByReplacingOccurrencesOfString:@" " withString:@""];
        longitudefile = [longitudefile stringByReplacingOccurrencesOfString:@"°" withString:@"."];
        latitudefile = [latitudefile stringByReplacingOccurrencesOfString:@"'" withString:@""];
        latitudefile = [latitudefile stringByReplacingOccurrencesOfString:@" " withString:@""];
        latitudefile = [latitudefile stringByReplacingOccurrencesOfString:@"°" withString:@"."];
        double flatitude = [latitudefile doubleValue];
        double flongitude = [longitudefile doubleValue];
        [self addGlobeMarker:  flatitude  theLongitude:   flongitude  locationName: location];
        
    }
    [self addGlobeMarker:  22  theLongitude:   11  locationName: @"°"];
    
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
    responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tudoporaqui.com.br/globe/globe.php"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addGlobeMarker:  0  theLongitude:   0  locationName:@""];
    
    

}

//Destructor
- (void)dealloc {    
	[theList     release];   // list of markers for the globe
	[aTempMarker release];   // temporary variable used while generating the main list array
    [super       dealloc];
}

@end
