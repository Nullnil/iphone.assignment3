//
//  AlbumController.m
//  SmartCamera
//
//  Created by sen hou on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlbumController.h"

@implementation AlbumController

@synthesize  managedObjectContext;
@synthesize photos;
@synthesize mapView;
@synthesize tableView;



#define MAP_BUTTON_TITLE @"Map"
#define LIST_BUTTON_TITLE @"List"

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!tableView && [self.view isKindOfClass:[UITableView class]]){
        tableView = (UITableView *)self.view;
    }
    
    self.view =[[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame ];
    
    self.tableView.frame = self.view.bounds;
    
    [self.view addSubview:self.tableView];
    
    self.mapView.frame = self.view.bounds;
    [self.view addSubview:self.mapView];
    
    self.mapView.hidden = YES;
    self.mapView.delegate = self;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:MAP_BUTTON_TITLE 
                                                                               style:UIBarButtonItemStyleBordered 
                                                                              target:self 
                                                                              action:@selector(toggleMap)]autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSManagedObjectContext *context = [self managedObjectContext];
    photos = [[NSArray alloc] initWithArray:[Photo getPhotoWithContext:context]];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* resize the UIImage */
-(UIImage *)resizeUIImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

- (MKMapView *)mapView{
    if (!mapView){
        mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame ];
    }
    return mapView;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"foo" ];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.leftCalloutAccessoryView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,30,30)]autorelease ];
    annotationView.canShowCallout = YES;
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)sender didSelectAnnotationView:(MKAnnotationView *)view{
    Photo *photo = nil;
    UIImageView *imageView = nil;
    
    if ([view.annotation isKindOfClass:[Photo class]]){
        photo = (Photo *)view.annotation;
    }
    
    if ([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]){
        imageView = (UIImageView *)view.leftCalloutAccessoryView;
    }
    
    if (photo && imageView){
        UIImage *image = [UIImage imageWithContentsOfFile:[photo name]];
        [imageView setImage:image];
    }
}

- (void)mapView:(MKMapView *)sender annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
    [detailViewController setPhoto:view.annotation];
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void) toggleMap{
    NSManagedObjectContext *context = [self managedObjectContext];
    if (self.mapView.isHidden){
        self.mapView.hidden = NO;
        self.tableView.hidden = YES;
        self.navigationItem.rightBarButtonItem.title = LIST_BUTTON_TITLE;
        [self.mapView addAnnotations:[Photo getPhotoWithContext:context]];
    }else{
        self.mapView.hidden = YES;
        self.tableView.hidden = NO;
        self.navigationItem.rightBarButtonItem.title = MAP_BUTTON_TITLE;        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSLog(@"testing2");
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Photo *currentPhoto = [photos objectAtIndex:[indexPath row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    //UIImage *image = [self resizeUIImage:[UIImage imageWithContentsOfFile:[currentPhoto name]] scaledToSize:CGSizeMake(44,44)];
    //[[cell imageView] setImage:image];
    [[cell textLabel] setText:[currentPhoto title]];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
    // ...
    [detailViewController setPhoto:[photos objectAtIndex:[indexPath row]]];
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
