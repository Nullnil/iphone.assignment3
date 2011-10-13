//
//  LocationController.m
//  WeatherReport
//
//  Created by sen hou on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationController.h"

@implementation LocationController

@synthesize delegate;
@synthesize receivedData;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void) getLocationByLatitude:(NSString*) latitude andLongitude:(NSString *) longitude{

    /*NSLog(@"get location by latitude and longitude");
    NSLog(@"%@ %@",latitude, longitude);
    NSString *myurl = [[NSString alloc]initWithFormat:
                       @"http://where.yahooapis.com/geocode?location=%@+%@&gflags=R&appid=OudSds36",latitude,longitude];
    NSURL *url = [NSURL URLWithString:myurl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection){
        receivedData = [[NSMutableData data] retain];
        NSLog(@"connected");
    }*/
    
    NSString *myurl = [[NSString alloc]initWithFormat:
                       @"http://where.yahooapis.com/geocode?location=%@+%@&gflags=R&appid=OudSds36",latitude,longitude];
    NSURL *url = [NSURL URLWithString:myurl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [myurl release];
    //NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *data =  [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    [self.delegate LocationController:self webserviceCallFinished:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"did receive response");
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
     NSLog(@" receive data");
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
    NSLog(@"finish load location");
    [self.delegate LocationController:self webserviceCallFinished:[receivedData autorelease]];
    [connection release];
}

- (void)dealloc {
    [super dealloc];
    [receivedData release];
}
@end
