//
//  LocationController.h
//  WeatherReport
//
//  Created by sen hou on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationDelegate;

@interface LocationController : NSObject{
    NSMutableData *receivedData;
    id<LocationDelegate> delegate;
}

@property (nonatomic,retain) NSMutableData *receivedData;
@property (assign) id<LocationDelegate> delegate;

- (void) getLocationByLatitude:(NSString*) latitude andLongitude:(NSString *) longitude;


@end


@protocol LocationDelegate
- (void)LocationController:(LocationController *)loadData webserviceCallFinished:(NSData *) receivedData;
@end
