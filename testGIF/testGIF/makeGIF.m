//
//  testCameraViewController.m
//  testCamera
//
//  Created by Le Yan on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "makeGIF.h"


#define IMAGE_COUNT       36
#define IMAGE_WIDTH       240
#define IMAGE_HEIGHT      180
#define STATUS_BAR_HEIGHT 20
#define SCREEN_HEIGHT     460
#define SCREEN_WIDTH      320
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation testCameraViewController
@synthesize imageView;
@synthesize takePhoto;
@synthesize upload;
@synthesize generate;
@synthesize times;
@synthesize images;
@synthesize filename;
@synthesize imageforpalette;

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    //[picker release];
}


-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}


-(void)imagePickerController:(UIImagePickerController*) picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [ info objectForKey:UIImagePickerControllerMediaType ];
    
    if([mediaType isEqualToString:(NSString *)@"public.movie"] == YES){
       
        NSURL *urlOfVideo = [ info objectForKey:UIImagePickerControllerMediaURL ];
        NSLog(@"Video URL = %@", urlOfVideo);
        
        // new asset 
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:urlOfVideo options:nil];
        // create new imagegenerator with asset 
        AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        Float64 duration= CMTimeGetSeconds([asset duration]);
        
        self.times = [ NSMutableArray arrayWithCapacity: 30];
        self.images = [ NSMutableArray arrayWithCapacity: 30];
        
        /* add time to array */
        CMTime time;
        for(int i=0; i <= duration; i++ ){
            time = CMTimeMakeWithSeconds(i, duration);
            [ self.times addObject:[NSValue valueWithCMTime:time]];
        }
        
        generator.appliesPreferredTrackTransform=YES;
     
        
        [generator generateCGImagesAsynchronouslyForTimes:times
                   completionHandler:^(CMTime requestedTime, CGImageRef image, 
                                       CMTime actualTime,
                                       AVAssetImageGeneratorResult result, NSError *error) {
                                            
            if (result == AVAssetImageGeneratorSucceeded) {
                NSLog(@"Got image");
                /* add images to array */
                [ self.images addObject:[self imageWithImage:[UIImage imageWithCGImage:image]
                           scaledToSize:CGSizeMake(130, 130)]];
                 
                /* check if its the last time */
                if( CMTimeCompare(requestedTime, time) == 0 ){
                
                  NSLog(@"Last time!c");  
                  self.imageforpalette = [self imageWithImage:[UIImage imageWithCGImage:image] 
                                               scaledToSize:CGSizeMake(50, 50)];
                                      
 
                  imageView.animationImages = [NSArray arrayWithArray:self.images ];
                
                  imageView.animationDuration = 1;
                
                  imageView.animationRepeatCount = 0;
                
                  [imageView startAnimating];
                
                  self.generate.hidden = NO;
                }

            }  
                                                 
            if (result == AVAssetImageGeneratorFailed) {
                        NSLog(@"Failed with error: %@", [error localizedDescription]);
            }
                                                 
            if (result == AVAssetImageGeneratorCancelled) {
                        NSLog(@"Canceled");
            }
                       
        }];
        
        [asset release];        
        //[generator release];
          
       [[picker parentViewController] dismissModalViewControllerAnimated:YES];
       //[picker release];

        
       

        
    }

        
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    if( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
    {
        NSLog(@"No camera");
        self.takePhoto.hidden = YES;
    }
    self.generate.hidden = YES;
    self.upload.hidden = YES;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setTakePhoto:nil];
    [self setGenerate:nil];
    [self setUpload:nil];
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
    [imageView release];
    [takePhoto release];
    [generate release];
    [upload release];
    [super dealloc];
}



- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
  
    NSLog(@"didshow");
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"willshow");
}



- (IBAction)uploadGIF:(id)sender {
    

    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:
                                   [NSURL URLWithString:@"https://www.tumblr.com/api/write"]];
    
   
    
    [request setPostValue:@"janusle@gmail.com" forKey:@"email"];
    [request setPostValue:@"YUYANGMM" forKey:@"password"];
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
    }
    else{
        int statusCode = [request responseStatusCode];
        NSLog(@"%d", statusCode);
        NSLog(@"%@", [request responseStatusMessage]);
        NSString *contentType = [[request responseHeaders] objectForKey:@"Content-Type"];
        NSLog(@"%@", contentType);
        NSLog(@"%@",[ error localizedDescription]);
        NSLog(@"%@",[ error localizedFailureReason]);
        
    }

    [request release];
    
    
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



- (IBAction)getPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init ];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: @"public.movie" , nil];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [ self presentModalViewController:picker
                             animated:YES ];
    
    [picker release ];
    
}



-(NSString*)generateNewGifName{
    char name[] = "XXXX";
    mktemp(name);
    NSString *gifname = [[ NSString alloc ] initWithFormat:@"%s.gif", name];
    [ gifname autorelease ];
    return gifname;
}


- (IBAction)generateGIF:(id)sender {
    
    if( self.images.count != 0 ){
        NSString * fileName = [NSString stringWithFormat:@"%@/Documents/%@", 
                                         NSHomeDirectory(),[self generateNewGifName ]];
        self.filename = fileName;
        NSLog(@"%@", fileName);
        
        ANPoint *mattePoint = [[ANPoint alloc] initWithR:255 withG:255 withB:255];
        
        /*
        CGRect rect = CGRectMake(0, 0, 6, 36);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        for(int i=0; i<=0xffff00; i=i+0x3300 )
            for( int j=0; j<=0x0000ff; j=j+0x33 ){ 
              CGContextSetFillColorWithColor(context, [ UIColorFromRGB(i+j) CGColor]);
              UIRectFill(CGRectMake(i%6, i/6, 1, 1));
            }
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        */
        
        ANGifPalette *palette = [[ANGifPalette alloc] initWithImage: self.imageforpalette.CGImage 
                                                          withMatte:mattePoint];
        
        ANGifEncoder * enc = [[ANGifEncoder alloc] initWithFile:fileName 
                                               withColorPalette:palette 
                                                       animated:YES];
        UIImage* im = [ self.images lastObject ];
        ANGifBitmap *bmp = [[ANGifBitmap alloc] initWithImage: im withColorPalette:palette];
        /* get CGSize of file */
        [ enc beginFile:bmp.size delayTime:1];
      
        
        for( UIImage* im in self.images ){
           ANGifBitmap * bmp = [[ANGifBitmap alloc] initWithImage: im withColorPalette:palette];
           [ enc addImage:bmp ]; 
           [ bmp release ];
        }
        [ im release ];
        [ bmp release ];
        
        [enc endFile];
        NSLog(@"GIF done");
        NSFileManager *fileManager = [[ NSFileManager alloc] init];
        NSDictionary * attributes = [ fileManager attributesOfItemAtPath:fileName error: nil ];
        NSLog(@"%d", [[attributes objectForKey:NSFileSize] intValue]);
        
        
        generate.hidden = YES;
        upload.hidden = NO;
        [ fileName release ];
        [ enc release ];
    
    }
    
}
@end
