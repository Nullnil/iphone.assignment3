//
//  XMLController.m
//  XMLParser
//
//  Created by sen hou on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLController.h"

@implementation XMLController

@synthesize weather;
@synthesize myParser;
@synthesize woeid;
@synthesize latitude;
@synthesize longitude;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        woeid = NO;
    }
    
    return self;
}

- (void)parseXMLFileByData:(NSData *)data//URL is the file path (i.e. /Applications/MyExample.app/MyFile.xml)
{	
    //you must then convert the path to a proper NSURL or it won't work
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    if (myParser){
        [myParser release];
    }
    myParser = [[NSXMLParser alloc]initWithData:data];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [myParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [myParser setShouldProcessNamespaces:YES];
    [myParser setShouldReportNamespacePrefixes:YES];
    [myParser setShouldResolveExternalEntities:NO];
	
    [myParser parse];
	
}

- (void)parseXMLFileByData:(NSMutableData *)data 
              withLatitude:(NSString *)lati 
              andLongitude:(NSString *)longi{
    
    [self setLatitude:lati];
    [self setLongitude:longi];
    
    if (myParser){
        [myParser release];
    }
    
    myParser = [[NSXMLParser alloc]initWithData:data];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [myParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [myParser setShouldProcessNamespaces:YES];
    [myParser setShouldReportNamespacePrefixes:YES];
    [myParser setShouldResolveExternalEntities:NO];
	
    [myParser parse];
    
    
}


- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
    //NSLog(@"found this element: %@", elementName);
    if ([elementName isEqualToString:@"condition"]){
        NSString *temperature = [attributeDict objectForKey:@"temp"];
        NSString *description = [attributeDict objectForKey:@"text"];
        weather = [[Weather alloc] initWeatherWith:temperature 
                                        dscription:description 
                                          latitude:latitude 
                                      andLongitude:longitude];
    }
    
    if ([elementName isEqualToString:@"woeid"]){
        woeidFound = YES;
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (woeidFound == YES){
        [self setWoeid:string];
        woeidFound = NO;
    }
}

@end
