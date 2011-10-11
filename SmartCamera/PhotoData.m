//
//  PhotoData.m
//  SmartCamera
//
//  Created by sen hou on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoData.h"

@implementation PhotoData

@synthesize name;
@synthesize photoTitle;
@synthesize latitude;
@synthesize longitude;
@synthesize temperature;
@synthesize weatherDescription;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)      initWithName: (NSString *)newName 
              photoTitle:(NSString *) newTitle 
                latitude:(NSString *)lati
               longitude:(NSString *)longi 
             temperature: (NSString *)newTemperature 
   andWeatherDescription:(NSString *)newWeatherDescription{
    self = [super init];
    if (self) {
        [self setName:newName];
        [self setPhotoTitle:newTitle];
        [self setLatitude:lati];
        [self setLongitude:longi];
        [self setTemperature:newTemperature];
        [self setWeatherDescription:newWeatherDescription];
    }
    
    return self;
}

- (void) dealloc{
    [super dealloc];
    [name release];
    [photoTitle release];
    [latitude release];
    [longitude release];
    [temperature release];
    [weatherDescription release];
}

@end
