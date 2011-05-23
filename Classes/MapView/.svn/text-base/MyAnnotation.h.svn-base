//
//  MyAnnotation.h
//  WhereRU
//
//  Created by Steven on 6/1/09.
//  Copyright 2009 Clever Coding LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@interface MyAnnotation : NSObject <MKAnnotation> {
	
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subTitle;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D) coord;
- (NSString *) title;
- (NSString *) subTitle;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subTitle;

@end

