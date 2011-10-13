//
//  Weather.m
//  XMLParser
//
//  Created by sen hou on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Weather.h"

@implementation Weather


@synthesize currentTemperature;
@synthesize description;
@synthesize latitude;
@synthesize longitude;

-(id) initWeatherWith:(NSString *)currentTemp
           dscription:(NSString *)newDecsription
             latitude: (NSString *)lati 
         andLongitude:(NSString *)longi{
    self = [super init];
    
    if (self){
        [self setCurrentTemperature:currentTemp];
        [self setDescription:newDecsription];
        [self setLatitude:lati];
        [self setLongitude:longi];
    }
    
    return  self;
    
}



- (void)dealloc {
    [currentTemperature release];
    [description release];
    [latitude release];
    [longitude release];
    [super dealloc];
}

@end
