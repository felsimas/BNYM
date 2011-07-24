//  Copyright 2011 Logic Diner. All rights reserved.

#import "MarkersForGlobeList.h"
#import "Presentation.h"
#import "PointData.h"
#import "Slide.h"
#import "Location.h"

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
    
    [[Presentation currentPresentation] initPointsArray];
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
    
   // NSLog(responseString);
    
    NSDictionary *dictionary = [responseString JSONValue];

    id item;
    for (item in dictionary) {
       // NSLog(@"item %@", item);
        if ([item valueForKey:@"title"] != nil){
            NSString *_aName  = [NSString stringWithFormat:@"%@",[item valueForKey:@"title"]];
            NSLog(@"_aName %@", _aName);
            [Presentation currentPresentation].title = _aName;
        }
        
        if ([item valueForKey:@"style"] != nil){
            NSString *_aStyle  = [NSString stringWithFormat:@"%@",[item valueForKey:@"style"]];
            NSLog(@"_aStyle %@", _aStyle);
            [Presentation currentPresentation].style = _aStyle;
        }
        
        /////////////
        [Presentation currentPresentation].survey = nil;
        ////////////
        
        if ([item valueForKey:@"points"] != nil){
            
            NSInteger pointsTotal = [[item valueForKey:@"points"] count];
           // NSLog(@"pointsTotal: %d",pointsTotal);
            
            NSInteger ix2;
            NSArray *points = (NSArray *) [item objectForKey:@"points"];  
            
            for (NSDictionary *point in [item objectForKey:@"points"])
            {
                
                ///////
                NSMutableArray *slidesArray = [[[NSMutableArray alloc]init]autorelease];
                
                
                //if ([point valueForKey:@"title"] != nil){
                    NSString *pointName  = [NSString stringWithFormat:@"%@",[point valueForKey:@"title"]];
                //}


                NSMutableDictionary *aLocationRef  = [NSString stringWithFormat:@"%@",[point valueForKey:@"location_ref"]];
                
                NSMutableDictionary *aSlideRef  = [NSString stringWithFormat:@"%@",[point valueForKey:@"slides"]];
                //NSLog(@"aSlideRef %@", aSlideRef);
               
                
                
                NSString *aLatitude = [[NSString alloc]init];
                NSString *aLongitude = [[NSString alloc]init];;
                NSString *aLocationTitle = [[NSString alloc]init];;
                
                ////////
                Location *location = [[[Location alloc]initWithTitle:aLocationTitle longitude:aLongitude latitude:aLatitude]retain];
                
                
                
                /*Begin of Location */
                if ([[point valueForKey:@"location_ref"] valueForKey:@"latitude"] != nil){
                    aLatitude = [NSString stringWithFormat:@"%@",[[point valueForKey:@"location_ref"] valueForKey:@"latitude"]];
                    NSLog(@"aLatitude %@", aLatitude);
                } 
                
                if ([[point valueForKey:@"location_ref"] valueForKey:@"longitude"] != nil){
                    aLongitude = [NSString stringWithFormat:@"%@",[[point valueForKey:@"location_ref"] valueForKey:@"longitude"]];
                    NSLog(@"aLongitude %@", aLongitude);
                } 
                
                if ([[point valueForKey:@"location_ref"] valueForKey:@"title"] != nil){
                    aLocationTitle = [NSString stringWithFormat:@"%@",[[point valueForKey:@"location_ref"] valueForKey:@"title"]];
                    NSLog(@"aLocationTitle %@", aLocationTitle);
                } 
                double flatitude = [aLatitude doubleValue];
                double flongitude = [aLongitude doubleValue];
                
                [self addGlobeMarker:flatitude  theLongitude:flongitude locationName:aLocationTitle];
                /*End of Location */
              //  NSInteger SlidesTotal = [dictionary count];

                for (id slide in [point objectForKey:@"slides"]){
                    
                    NSString *aMedia = @"";
                    NSString *aSlideTitle = @"";
                    NSString *aOrder = @"";
                    
                /*Begin of Slide */
                    if ([slide valueForKey:@"media"] != nil){
                        aMedia = [NSString stringWithFormat:@"%@",[slide valueForKey:@"media"]];
                        NSLog(@"aMedia %@", aMedia);
                    } 
                
                    if ([slide valueForKey:@"order"] != nil){
                        aOrder = [NSString stringWithFormat:@"%@",[slide valueForKey:@"order"]];
                        NSLog(@"aOrder %@", aOrder);
                    } 
                
                    if ([slide valueForKey:@"title"] != nil){
                        aSlideTitle = [NSString stringWithFormat:@"%@",[slide valueForKey:@"title"]];
                        NSLog(@"aSlideTitle %@", aSlideTitle);
                    }  
                    
                    Slide *slideObj = [[[Slide alloc]initWithMedia:aMedia order:aOrder title:aSlideTitle]retain];
                    
                    [slidesArray addObject:slideObj];
                /*End of Slide */
                }
                                            
                PointData *dataPoint = [[[PointData alloc]initWithTitle:pointName slides:slidesArray location:location]retain];
                
                [[Presentation currentPresentation].points addObject:dataPoint];
                
            }
            
         

            
        }

    }
    int count = [[Presentation currentPresentation].points count];
    NSLog(@"presentation points count %d", count);
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
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ec2-174-129-66-92.compute-1.amazonaws.com/api/presentation/"]];
    /*http://tudoporaqui.com.br/globe/globe.php*/
    
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
