//
//  WeatherReport.h
//  WeatherReport
//
//  Created by sen hou on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Weather.h"
#import "WeatherCollector.h"
#import "XMLController.h"
#import "LocationController.h"
#import "MyCLController.h"
#import "Location.h"


@protocol WeatherDelegate;

@interface WeatherReport : NSObject <WebserviceDelegate , LocationDelegate, MyCLControllerDelegate>{
    
    WeatherCollector *weatherCollector;
    XMLController *xmlController;
    LocationController *locationController;
    MyCLController *myCLController;
    //NSMutableData * data;
    //NSMutableData * locationData;
    
    NSData * data;
    NSData * locationData;
    BOOL hasLoaded;
    BOOL locationHasLoaded;
    BOOL hasLocation;
    Weather *weather;
    Location *location;
    id <WeatherDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet WeatherCollector *weatherCollector;
@property (nonatomic, retain) IBOutlet LocationController *locationController;
@property (nonatomic, retain) XMLController *xmlController;
@property (nonatomic, retain) NSData * locationData;
@property (nonatomic, retain) NSData * data;

//@property (nonatomic, retain) NSMutableData * locationData;
//@property (nonatomic, retain) NSMutableData * data;

@property (assign) id <WeatherDelegate> delegate;
@property (nonatomic, retain) Weather *weather;
@property (nonatomic, retain) Location *location;

- (void)getTemperature;


//- (void)WeatherCollector:(WeatherCollector *)loadData webserviceCallFinished:(NSMutableData *) receivedData;
//- (void)LocationController:(LocationController *)loadData webserviceCallFinished:(NSMutableData *) receivedData;

- (void)WeatherCollector:(WeatherCollector *)loadData webserviceCallFinished:(NSData *) receivedData;
- (void)LocationController:(LocationController *)loadData webserviceCallFinished:(NSData *) receivedData;

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;


@end

@protocol WeatherDelegate
- (void)WeatherReport:(WeatherReport *)loadData weatherFinished:(Weather *)weather;
@end
