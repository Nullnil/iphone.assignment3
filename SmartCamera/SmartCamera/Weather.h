//
//  Weather.h
//  XMLParser
//
//  Created by sen hou on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject{
    NSString *currentTemperature;
    NSString *description;
    NSString* latitute;
    NSString* longitute;
}

@property (nonatomic, copy)NSString *currentTemperature;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* longitude;

-(id) initWeatherWith:(NSString *)currentTemperature 
           dscription:(NSString *)decsription
             latitude: (NSString *)lati 
         andLongitude:(NSString *)longi;

@end
