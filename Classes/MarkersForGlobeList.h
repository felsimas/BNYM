//  Copyright 2011 Logic Diner. All rights reserved.


#import <Foundation/Foundation.h>
#import "GlobeMarker.h"

@interface MarkersForGlobeList : NSObject {
	NSMutableArray *theList;                 // list of markers for the globe
	GlobeMarker *aTempMarker;             // temporary variable used while generating the main list array
}

@property (retain) NSMutableArray *theList;  //list of markers for the globe


-(void)addGlobeMarker:(float)lat
		 theLongitude:(float)lon
		 locationName:(NSString *)locName;

//function generates the list and is called in the "init" function whenever a MarkersForGlobeList object is created
-(void)generateTheList;


@end
