//
//  GenerateGIFController.m
//  testGIF
//
//  Created by Le Yan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UploadGIFController.h"

@implementation UploadGIFController
@synthesize shareToTumblr;
@synthesize HUD;
@synthesize filename;
@synthesize swith;
@synthesize textField;
@synthesize username;
@synthesize password;
@synthesize weather;

- (void)passUserInfo:(NSString*)usrname 
            password:(NSString*)pass
{
    
    self.username = usrname;
    self.password = pass;
    NSLog(@"%@:%@", self.username, self.password);
}



- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    self.HUD = nil;
    NSLog(@"hidden");
}


#define UPLOADPICTURENAME @"share.gif"

-(void)uploadtoTumblr{
    
    
    NSLog(@"Start");
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:
                                   [NSURL URLWithString:@"https://www.tumblr.com/api/write"]];
    
    
    [request setPostValue:self.username forKey:@"email"];
    [request setPostValue:self.password forKey:@"password"];
    [request setPostValue:@"photo" forKey:@"type"];
    NSString* caption;
    
    if ( swith.on == YES )
        caption = [[NSString alloc] initWithFormat: @"Weather: %@ I want to say: %@",
                           self.weather.description , self.textField.text ];
    else
        caption = [[NSString alloc] initWithFormat: @"I want to say: %@",
                   self.weather.description , self.textField.text ];
    
    [request setPostValue:caption forKey:@"caption"];
    [ caption release ];
    [request setFile:self.filename withFileName:UPLOADPICTURENAME andContentType:@"image/gif"
              forKey:@"data"];
    [request startSynchronous];
    
    NSLog(@"Initializing done");
    
    NSError *error = [request error];
    if (!error) {
        
        int statusCode = [request responseStatusCode];
        NSLog(@"%d", statusCode );
        
        /* status Code is 2xx */
        if ( statusCode >= 200 && statusCode <= 300 ){
          NSLog(@"Upload successfully");
        
          /* display complete screen */
          HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]] autorelease];
          HUD.mode = MBProgressHUDModeCustomView;
          HUD.labelText = @"Completed";
          sleep(2);
        }
        else
        {
          HUD.labelText = @"Failed to upload";
          HUD.detailsLabelText = @"Please check network settings";
          sleep(2);
        }
        
    }
    else{
        
        int statusCode = [request responseStatusCode];
        NSLog(@"%d", statusCode);
        NSLog(@"%@", [request responseStatusMessage]);
        NSString *contentType = [[request responseHeaders] objectForKey:@"Content-Type"];
        NSLog(@"%@", contentType);
        NSLog(@"%@",[ error localizedDescription]);
        NSLog(@"%@",[ error localizedFailureReason]);
        
        /* display failure screen */
        HUD.labelText = @"Failed to upload";
        HUD.detailsLabelText = @"Please check network settings";
        sleep(2);
        
    }
    
    [request release]; 
    NSLog(@"Finish to upload");
}



-(void)sharetoTumblr{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
	
    [HUD showWhileExecuting:@selector(uploadtoTumblr) onTarget:self withObject:nil animated:YES];
    
}



- (IBAction)share:(id)sender {
    
    
    if ([FileManager isFileExist] == NO){
        loginView* lv = [[loginView alloc] init];
        lv.delegate = self;
        [ self presentModalViewController:lv animated:YES ];
        [ lv release ];
    }else{
        User *user = [FileManager readFromFile:@"user.txt"];
        [self passUserInfo:user.userName password:user.password];
        [self sharetoTumblr];
        //[ user release ];
    }
    
    
}



- (IBAction)dissmissKeyboard:(id)sender {
}



-(id)initWithFileName:(NSString*)name 
           andWeather:(Weather*)weatherInfo{
    self = [ super init ];
    if( self ){
        self.filename = name; 
        self.weather = weatherInfo;
    }
    
    return self;
}



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
    //webView = [self initWebView];
    //NSLog(@"%@",webView);
    self.HUD = nil;
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    
    [self setShareToTumblr:nil];
    [self setSwith:nil];
    [self setTextField:nil];
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
    
    [shareToTumblr release];
    [swith release];
    [textField release];
    [super dealloc];
}
@end
