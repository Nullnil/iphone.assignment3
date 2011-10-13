//
//  WeatherCollector.m
//  WeatherReport
//
//  Created by sen hou on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeatherCollector.h"

@implementation WeatherCollector

@synthesize receivedData;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

/*get temperature by woeid number*/
- (void) getTemperature:(NSString *)woeid{
    
    NSString *myurl = [[NSString alloc]initWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@&u=c",woeid ];
    NSURL *url = [NSURL URLWithString:myurl];
    [myurl release];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *data =  [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    [self.delegate WeatherCollector:self webserviceCallFinished:data];
}
- (void) dealloc{
    [super dealloc];
    [receivedData release];
}

@end
