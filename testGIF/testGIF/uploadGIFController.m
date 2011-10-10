//
//  GenerateGIFController.m
//  testGIF
//
//  Created by Le Yan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UploadGIFController.h"

@implementation uploadGIFController
@synthesize shareToTumblr;
@synthesize HUD;
@synthesize filename;
@synthesize username;
@synthesize password;

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



-(void)uploadtoTumblr{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:
                                   [NSURL URLWithString:@"https://www.tumblr.com/api/write"]];

   
    //request.shouldPresentAuthenticationDialog = YES;
    
   
    //[request setPostValue:@"janusle@gmail.com" forKey:@"email"];
    [request setPostValue:self.username forKey:@"email"];
    //[request setPostValue:@"YUYANGMM" forKey:@"password"];
    [request setPostValue:self.password forKey:@"password"];
    [request setPostValue:@"photo" forKey:@"type"];
    [request setPostValue:@"test" forKey:@"title"];
    [request setPostValue:@"It's a test" forKey:@"body"]; 
    [request setFile:self.filename withFileName:@"test.gif" andContentType:@"image/gif"
              forKey:@"data"];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        int statusCode = [request responseStatusCode];
        NSLog(@"%d", statusCode );
        NSLog(@"Upload successfully");
        
        /* display complete screen */
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = @"Completed";
        sleep(2);
        
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
        //HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = @"Completed";
        sleep(2);
        
    }
    
    [request release]; 
    
}


-(void)sharetoTumblr{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
	
    [HUD showWhileExecuting:@selector(uploadtoTumblr) onTarget:self withObject:nil animated:YES];

}


- (IBAction)share:(id)sender {
    
    loginView* lv = [[loginView alloc] init];
    lv.delegate = self;
    [ self presentModalViewController:lv animated:YES ];
    [ lv release ];
    
       
    
    /*
    
     MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
     picker.mailComposeDelegate = self;
     [picker setSubject:@"Picture from my iPhone!"];
     
     
     NSString *emailBody = @"I just took this picture, check it out.";
     
     [picker setMessageBody:emailBody isHTML:YES];
     
     
     NSData *image = [[NSData alloc] initWithContentsOfFile:self.filename]; 
     
     
     [picker addAttachmentData:image mimeType:@"image/gif" fileName:@"CameraImage"];
     
     
     [self presentModalViewController:picker animated:YES];
     
     [picker release];
     */
     
}


-(id)initWithFileName:(NSString*)name{
    self = [ super init ];
    if( self ){
        self.filename = name; 
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
    self.HUD = nil;
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{

    [self setShareToTumblr:nil];
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
    [super dealloc];
}
@end
