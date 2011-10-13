//
//  XMLController.h
//  XMLParser
//
//  Created by sen hou on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
@interface XMLController : NSObject <NSXMLParserDelegate>{
    
    Weather *weather;
    NSXMLParser *myParser;
    NSString *woeid;
    BOOL woeidFound;
    
    NSString* latitute;
    NSString* longitute;
}

@property (nonatomic, retain) Weather *weather;
@property (nonatomic, retain) NSXMLParser *myParser;
@property (nonatomic, retain) NSString *woeid;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* longitude;


- (void)parseXMLFileByData:(NSData *)data;

- (void)parseXMLFileByData:(NSData *)data 
              withLatitude:(NSString *)lati 
              andLongitude:(NSString *)longi;

@end
