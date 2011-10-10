//
//  testThreadViewController.m
//  testThread
//
//  Created by Le Yan on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "testThreadViewController.h"

@implementation testThreadViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)testThread1

{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // Top-level pool
    
    
    for(int i=0; i<100000; i++ )
      NSLog(@"testThread1");
    
    
    
    [pool release];  // Release the objects in the pool.
    
}


- (void)testThread2

{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // Top-level pool
    
    
     for(int i=0; i<100000; i++ )
        NSLog(@"testThread2");
    
    
    
    [pool release];  // Release the objects in the pool.
    
}



- (IBAction)startA:(id)sender {
   
    [NSThread detachNewThreadSelector:@selector(testThread1) toTarget:self withObject:nil];
}

- (IBAction)startB:(id)sender {
    [NSThread detachNewThreadSelector:@selector(testThread2) toTarget:self withObject:nil];
}
@end
