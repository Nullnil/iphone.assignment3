//
//  Setting.m
//  SmartCamera
//
//  Created by sen hou on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Setting.h"

@implementation Setting
@synthesize password;
@synthesize userName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    
    User *user = [FileManager readFromFile:@"user.txt"];
    [userName setText:[user userName]];
    [password setText:[user password]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [userName release];
    [password release];
    [super dealloc];
}
- (IBAction)saveUserInfo:(id)sender {
    
    User *user = [[User alloc] initWithUserName:[userName text] andPassword:[password text]];
    
    [FileManager writeToFile:user withFileName:@"user.txt"];
    
}

- (IBAction)dismissKeyBoard:(id)sender {
}
@end
