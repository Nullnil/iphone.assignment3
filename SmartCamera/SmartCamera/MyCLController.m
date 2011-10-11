//
//  MyCLController.m
//  Location
//
//  Created by sen hou on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCLController.h"

@implementation MyCLController

@synthesize locationManager;
@synthesize delegate;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self; // send loc updates to myself
    }
    
    return self;
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self.delegate locationUpdate:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	[self.delegate locationError:error];
}

- (void)dealloc {
    //[self.locationManager release];
    [super dealloc];
}

@end
