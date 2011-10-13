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
@synthesize arrayBackgrounds;
@synthesize arrayColours;
@synthesize ColourPicker;


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
    
     self.arrayBackgrounds = [[NSMutableArray alloc] init];
    [self.arrayBackgrounds addObject:@"Lomo"];
    [self.arrayBackgrounds addObject:@"Fish eye"];
    [self.arrayBackgrounds addObject:@"Sea"];
    
     self.arrayColours = [[NSMutableArray alloc] init];
    [self.arrayColours addObject:@"White"];
    [self.arrayColours addObject:@"Grey"];
    [self.arrayColours addObject:@"Brown"];

}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    /* we need show two components */    
    return 2;
}


#define background 0
#define colours 1

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    if( component == colours )
      return [self.arrayColours count];
    else
      return [self.arrayBackgrounds count ];
    
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if( component == colours )
        return [self.arrayColours objectAtIndex:row];
    else
        return [self.arrayBackgrounds objectAtIndex:row ];
    
}


#define LOMO @"lomo.jpg"
#define FISHEYE @"fisheye.jpg"
#define PICS @"pics.jpg"
#define POSITIONOFCAMERA 0
#define POSITIONOFSETTING 1

/* when user select an item in picker, change background of 'camera' */
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"Selected Color: %@. Index of selected color: %i", [self.arrayColours objectAtIndex:row], row);
    
    if( component == background ){
      /* change background picture of 'camera' */
      UINavigationController *nb = [ self.tabBarController.viewControllers objectAtIndex:POSITIONOFCAMERA ];
    
      for( UIViewController* vc in nb.viewControllers ){
        if ([ vc respondsToSelector:@selector(changeBackground:) ] ){
          NSLog(@"ChangeBcakground found!");
          [ vc performSelector:@selector(changeBackground:) withObject:[ NSNumber numberWithInt:row ] ];
        }
      }
        
    }
    else{ /* change background colour of 'setting' */
        
        UIViewController *vc = [ self.tabBarController.viewControllers objectAtIndex: POSITIONOFSETTING];
        /* change setting background colour to red */
        if( row == 0 )
            vc.view.backgroundColor = [ UIColor whiteColor ];
        
        /* change setting background colour to blue */
        if( row == 1 )
            vc.view.backgroundColor = [ UIColor grayColor ];
        
        /* change setting background colour to brown */
        if( row == 2 )
            vc.view.backgroundColor = [ UIColor brownColor ];
        
    }
    
}


- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setColourPicker:nil];
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
    [ColourPicker release];
    [super dealloc];
}



- (IBAction)saveUserInfo:(id)sender {
    
    User *user = [[User alloc] initWithUserName:[userName text] andPassword:[password text]];
    
    [FileManager writeToFile:user withFileName:@"user.txt"];
    
}



- (IBAction)dismissKeyBoard:(id)sender {
}
@end
