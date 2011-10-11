//
//  WeatherCollector.h
//  WeatherReport
//
//  Created by sen hou on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol WebserviceDelegate;


@interface WeatherCollector : NSObject{
    NSMutableData *receivedData;
    id<WebserviceDelegate> delegate;

}

@property (nonatomic,retain) NSMutableData *receivedData;
@property (assign) id<WebserviceDelegate> delegate;


- (void) getTemperature:(NSString*) woeid;


@end

@protocol WebserviceDelegate
//- (void)WeatherCollector:(WeatherCollector *)loadData webserviceCallFinished:(NSMutableData *) receivedData;
- (void)WeatherCollector:(WeatherCollector *)loadData webserviceCallFinished:(NSData *) receivedData;
@end
