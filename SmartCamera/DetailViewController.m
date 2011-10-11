//
//  DetailViewController.m
//  SmartCamera
//
//  Created by sen hou on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize webView;
@synthesize description;
@synthesize temperature;
@synthesize photo;

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
    
    [temperature setText:[photo temperature]];
    [description setText:[photo weatherDescription]];
    
    //NSString* gifFileName = @"image.gif";
	NSMutableString* htmlStr = [NSMutableString string];
	[htmlStr appendString:@"<img src=\""];
	[htmlStr appendFormat:@"%@",[photo name]];
	[htmlStr appendString:@"\" alt=\"picture\"/>"];
	[webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTemperature:nil];
    [self setTemperature:nil];
    [self setDescription:nil];
    [self setWebView:nil];
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
    [temperature release];
    [temperature release];
    [description release];
    [webView release];
    [super dealloc];
}
@end
