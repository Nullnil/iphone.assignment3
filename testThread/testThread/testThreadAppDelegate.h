//
//  testThreadAppDelegate.h
//  testThread
//
//  Created by Le Yan on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class testThreadViewController;

@interface testThreadAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet testThreadViewController *viewController;

@end
