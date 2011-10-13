//
//  WeatherReport.m
//  WeatherReport
//
//  Created by sen hou on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeatherReport.h"

@implementation WeatherReport

@synthesize weatherCollector;
@synthesize locationController;
@synthesize data;
@synthesize xmlController;
@synthesize locationData;
@synthesize delegate;
@synthesize weather;
@synthesize location;



- (id)init
{
    self = [super init];
    if (self) {
        myCLController = [[MyCLController alloc] init];
        myCLController.delegate = self;
        [myCLController.locationManager startUpdatingLocation];
        
        weatherCollector = [[WeatherCollector alloc]init ];
        weatherCollector.delegate = self;
        hasLoaded = NO;
        
        xmlController = [[XMLController alloc]init ];
        
        locationController = [[LocationController alloc]init ];
        locationController.delegate = self;
        locationHasLoaded = NO;
        
        hasLocation = NO;
    }
    return self;
}



- (void)getTemperature{
    
    [locationController getLocationByLatitude:[self.location latitude] andLongitude:[self.location longitude]];
    //[location getLocationByLatitude:@"-37.737703" andLongitude:@"144.964742"];
}

- (void)LocationController:(LocationController *)loadData webserviceCallFinished:(NSData *) receivedData{
    locationHasLoaded = YES;
    if (locationData){
        [locationData release];
    }
    
    locationData = [receivedData retain];
    
    if (locationHasLoaded){
        [xmlController parseXMLFileByData:locationData];
        [weatherCollector getTemperature:[xmlController woeid]];
        locationHasLoaded = NO;
    }
}

-(void) WeatherCollector:(WeatherCollector *)loadData webserviceCallFinished:(NSMutableData *)receivedData{
    hasLoaded = YES;
    if (data){
        [data release];
    }
    data = [receivedData retain];
    if (hasLoaded){
        [xmlController parseXMLFileByData:data withLatitude:[self.location latitude] andLongitude:[self.location longitude]];
        hasLoaded = NO;
        [self.delegate WeatherReport:self weatherFinished:[xmlController weather]];
    }
}

- (void)locationUpdate:(CLLocation *)newLocation{
    
    NSString * latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    NSString * longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    location = [[Location alloc]initLocationWithLatitude:latitude andLongitude:longitude];
}
- (void)locationError:(NSError *)error{
    
}

-(void) dealloc{
    [super dealloc];
    [location release];
    [weather release];
    [xmlController release];
    [locationController release];
    [weatherCollector release];
    [data release];
    [locationData release];
}


@end
