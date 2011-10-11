//
//  Photo.m
//  SmartCamera
//
//  Created by sen hou on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Photo.h"


@implementation Photo
@dynamic name;
@dynamic photoTitle;
@dynamic latitude;
@dynamic longitude;
@dynamic temperature;
@dynamic weatherDescription;


+ (NSArray *)getPhotoWithContext:context{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" 
                                              inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    return fetchedObjects;
}

+ (Photo *) savePhotoWithPhotoData:(PhotoData *)photoData inManagedObjectContext:(NSManagedObjectContext *)context{
    
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    photo.name = photoData.name;
    photo.photoTitle = photoData.photoTitle;
    photo.latitude = photoData.latitude;
    photo.longitude = photoData.longitude;
    photo.temperature = photoData.temperature;
    photo.weatherDescription = photoData.weatherDescription;
    
    [photo setValue: photoData.name forKey:@"name"];
    [photo setValue: photoData.photoTitle forKey:@"photoTitle"];
    [photo setValue: photoData.latitude forKey:@"latitude"];
    [photo setValue: photoData.longitude forKey:@"longitude"];
    [photo setValue: photoData.temperature forKey:@"temperature"];
    [photo setValue: photoData.weatherDescription forKey:@"weatherDescription"];
    
    NSError *error;
	
	// here's where the actual save happens, and if it doesn't we print something out to the console
	if (![context save:&error]) 
	{
		NSLog(@"Problem saving: %@", [error localizedDescription]);
	}
    
    return photo;
}

- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D location;
    location.latitude = [self.latitude doubleValue];
    location.longitude = [self.longitude doubleValue];
    return location;
}

- (NSString *)title{
    NSString *name = self.photoTitle;
    return name;
}
@end
