//
//  testNavationControllerAppDelegate.h
//  testNavationController
//
//  Created by Le Yan on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "test1.h"
#import "test2.h"


@interface testNavationControllerAppDelegate : NSObject <UIApplicationDelegate>
{
      
    UINavigationController *navigationController;
    
}



@property (nonatomic,retain) UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
