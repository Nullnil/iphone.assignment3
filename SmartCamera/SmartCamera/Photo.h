//
//  Photo.h
//  SmartCamera
//
//  Created by sen hou on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import "PhotoData.h"


@interface Photo : NSManagedObject <MKAnnotation>{
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * photoTitle;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * temperature;
@property (nonatomic, retain) NSString * weatherDescription;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;


+ (Photo *) savePhotoWithPhotoData:(PhotoData *)photoData inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)getPhotoWithContext:context;
@end
