//
//  AlbumController.h
//  SmartCamera
//
//  Created by sen hou on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "DetailViewController.h"

@interface AlbumController : UITableViewController <MKMapViewDelegate>{
    NSManagedObjectContext *managedObjectContext;
    NSArray *photos;
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *photos;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;


/* resize the UIImage */
-(UIImage *)resizeUIImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end
