//
//  Location.m
//  WeatherReport
//
//  Created by sen hou on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize latitude;
@synthesize longitude;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) initLocationWithLatitude:(NSString*)lati andLongitude:(NSString*)longi{
    self = [super init];
    if (self) {
        [self setLatitude:lati];
        [self setLongitude:longi];
    }
    
    return self;
}

- (void) dealloc{
    [super dealloc];
    [latitude release];
    [longitude release];
}
@end
