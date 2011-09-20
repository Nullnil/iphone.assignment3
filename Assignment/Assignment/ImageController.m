//
//  FirstViewController.m
//  Assignment
//
//  Created by sen hou on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageController.h"

@implementation ImageController

@synthesize cameraButton;
@synthesize photoButton;
@synthesize imageView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera]){
        cameraButton.hidden = YES;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [self setCameraButton:nil];
    [self setPhotoButton:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [cameraButton release];
    [photoButton release];
    [imageView release];
    [super dealloc];
}



- (IBAction)choosePhoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *picker =  [[UIImagePickerController alloc] init];
//        picker.delegate = self;
        
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    }    
}

- (IBAction)takePhoto:(id)sender {
}
@end
