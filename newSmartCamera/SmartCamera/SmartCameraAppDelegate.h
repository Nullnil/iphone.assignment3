//
//  SmartCameraAppDelegate.h
//  SmartCamera
//
//  Created by sen hou on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlbumController;
@class VideoTakingController;

@interface SmartCameraAppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController *_tabBarController;
    AlbumController *albumController;
    VideoTakingController *videoTakingController;
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet VideoTakingController *videoTakingController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AlbumController *albumController;


@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

#import "AlbumController.h"
#import "VideoTakingController.h"
