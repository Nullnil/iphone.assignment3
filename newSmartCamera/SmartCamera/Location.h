//
//  Location.h
//  WeatherReport
//
//  Created by sen hou on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject {
    NSString* latitude;
    NSString* longitude;
}

@property (nonatomic, retain)NSString* latitude;

@property (nonatomic, retain)NSString* longitude;

- (id) initLocationWithLatitude:(NSString*)lati andLongitude:(NSString*)longi;
@end
