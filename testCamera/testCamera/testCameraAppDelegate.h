//
//  testCameraAppDelegate.h
//  testCamera
//
//  Created by Le Yan on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class testCameraViewController;

@interface testCameraAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet testCameraViewController *viewController;

@end
