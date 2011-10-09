//
//  test1.m
//  testNavationController
//
//  Created by Le Yan on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "test1.h"

@implementation test1

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

-(void)performRight{
   test2 *t2;
   t2 = [[test2 alloc] init ];
   [ self.navigationController pushViewController:t2 animated:YES];
   [ t2 release ]; 
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton;
    
    rightButton = [[ UIBarButtonItem alloc] initWithTitle:@"test2" 
                                                style:UIBarButtonItemStylePlain 
                                               target:self 
                                               action:@selector(performRight)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    [ rightButton release ];
    
}

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

@end
