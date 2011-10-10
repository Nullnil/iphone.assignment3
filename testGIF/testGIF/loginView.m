//
//  loginView.m
//  testGIF
//
//  Created by Le Yan on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "loginView.h"

@implementation loginView
@synthesize username;
@synthesize password;
@synthesize delegate;


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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPassword:nil];
    [self setUsername:nil];
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
    [password release];
    [username release];
    [super dealloc];
}


- (IBAction)login:(id)sender {
    
    NSString *usrname = self.username.text;
    NSString *pass = self.password.text;
    
    
    [ self.delegate passUserInfo:usrname password:pass ];
    [ self.delegate sharetoTumblr ];
    [ self dismissModalViewControllerAnimated:YES ];  
    

}



- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];  
}
@end
