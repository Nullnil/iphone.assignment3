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

- (void) getTemperature:(NSString *)woeid{
    

    /*NSString *myurl = [[NSString alloc]initWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@&u=c",woeid ];
    NSURL *url = [NSURL URLWithString:myurl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection){
        receivedData = [[NSMutableData data] retain];
    }*/
    
    NSString *myurl = [[NSString alloc]initWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@&u=c",woeid ];
    NSURL *url = [NSURL URLWithString:myurl];
    [myurl release];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    //NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *data =  [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    //[self.delegate WeatherCollector:self webserviceCallFinished:[data autorelease]];
    [self.delegate WeatherCollector:self webserviceCallFinished:data];
}

/*- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [connection release];
    
    [receivedData release];
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate WeatherCollector:self webserviceCallFinished:[receivedData autorelease]];
    [connection release];
}*/



@end
