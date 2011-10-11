//
//  PhotoData.h
//  SmartCamera
//
//  Created by sen hou on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoData : NSObject{

    NSString * name;    
    NSString * photoTitle;
    NSString * latitude;
    NSString * longitude;
    NSString * temperature;
    NSString * weatherDescription;
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * photoTitle;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * temperature;
@property (nonatomic, retain) NSString * weatherDescription;

- (id)      initWithName: (NSString *)name 
              photoTitle:(NSString *) title 
                latitude:(NSString *)lati
               longitude:(NSString *)longi 
             temperature: (NSString *)temperature 
   andWeatherDescription:(NSString *)weatherDescription;

@end
