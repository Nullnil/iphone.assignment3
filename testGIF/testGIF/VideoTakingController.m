//
//  testCameraViewController.m
//  testCamera
//
//  Created by Le Yan on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoTakingController.h"


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


@implementation VideoTakingController


@synthesize times;
@synthesize images;
@synthesize filename;
@synthesize imageforpalette;
@synthesize HUD;
@synthesize generategifbutton;
@synthesize imageView;



- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    self.HUD = nil;
    NSLog(@"hidden");
}


/* resize the UIImage */
-(UIImage *)resizeUIImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}




-(void)displayFakeGIF{
    
    NSLog(@"%d", self.images.count);
    
    imageView.animationImages = [NSArray arrayWithArray:self.images];
    
    imageView.animationDuration = 1;
    
    imageView.animationRepeatCount = 0;
    
    [imageView startAnimating];
}



/* get thumbnails from video */
-(void)getThumbnails:(NSDictionary *)info{
    
    sleep(1);
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
                                            [ self.images addObject:[self resizeUIImage:[UIImage imageWithCGImage:image]
                                                                           scaledToSize:CGSizeMake(130, 130)]];
                                            
                                            /* check if its the last time */
                                            if( CMTimeCompare(requestedTime, time) == 0 ){
                                                
                                                NSLog(@"Last time!c");  
                                                self.imageforpalette = [self resizeUIImage:[UIImage imageWithCGImage:image] 
                                                                              scaledToSize:CGSizeMake(120, 120)];
                                                
                        
                                                [ self displayFakeGIF ];
                                                
                                                
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
    
   
    //[picker release];
    

    
    
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    
}



-(void)imagePickerController:(UIImagePickerController*) picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [ info objectForKey:UIImagePickerControllerMediaType ];
    
    if([mediaType isEqualToString:(NSString *)@"public.movie"] == YES){
        
        /* call waiting screen */
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Extracting thumbnails";
    
        [HUD showWhileExecuting:@selector(getThumbnails:) onTarget:self withObject:info animated:YES];
        //[ self getThumbnails:info ];        
        
        
        [[picker parentViewController] dismissModalViewControllerAnimated:YES];
        
        
    }
 
}

#define MAXDURATION 5

-(void)popCamera{
    
    /* pop up camera */
    self.imageforpalette = nil;
    self.images = nil;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init ];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: @"public.movie" , nil];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.wantsFullScreenLayout = NO;
    picker.navigationBarHidden = NO;
    picker.videoMaximumDuration = MAXDURATION;
    [ self presentModalViewController:picker
                             animated:YES ];
    
    [picker release ];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* show camera */
    if( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
    {
        NSLog(@"No camera");
    }
    
    [ self popCamera ];
}





- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



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



- (void)dealloc {

    [super dealloc];
}


/* generate a new gif name */
-(NSString*)generateNewGifName{
    char name[] = "XXXX";
    mktemp(name);
    NSString *gifname = [[ NSString alloc ] initWithFormat:@"%s.gif", name];
    [ gifname autorelease ];
    return gifname;
}


/* perform UploadGIFController */
-(void)performUploadGIFController:(NSString*)name{
    
    uploadGIFController * upgif = [[uploadGIFController alloc] initWithFileName: name ];
    //uploadGIFController *upgif = [[uploadGIFController alloc]init];
    
    if( upgif ){
      [self.navigationController pushViewController:upgif animated:YES];
      [upgif release];
    }
}



-(BOOL)generateGIFfrompics{
    
    NSString * fileName = [NSString stringWithFormat:@"%@/Documents/%@", 
                           NSHomeDirectory(),[self generateNewGifName ]];
    self.filename = fileName;
    NSLog(@"%@", fileName);
    
    ANPoint *mattePoint = [[ANPoint alloc] initWithR:255 withG:255 withB:255];
    
    ANGifPalette *palette = [[ANGifPalette alloc] initWithImage: self.imageforpalette.CGImage 
                                                      withMatte:mattePoint];
    
    ANGifEncoder * enc = [[ANGifEncoder alloc] initWithFile:fileName 
                                           withColorPalette:palette 
                                                   animated:YES];
    UIImage* im = [ self.images lastObject ];
    ANGifBitmap *bmp = [[ANGifBitmap alloc] initWithImage: im withColorPalette:palette];
    /* get CGSize of file */
    
    [ enc beginFile:bmp.size delayTime:1];
    
    /* change mode of waiting screen */
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.labelText = @"Generating GIF";
    HUD.detailsLabelText = nil;
    float progress = 0.0f;
    int i = 1;
    
    NSLog(@"%d", self.images.count);
    for( UIImage* im in self.images ){
        
        /* increment progress */
        progress += ((float)i)/(self.images.count*2);
        NSLog(@"%f\n", progress);
        self.HUD.progress = progress;
        
        NSLog(@"%d", i);
        i += 1;
        
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
    
    [ fileName release ];
    [ enc release ];
    
    /* increment progress */
    progress = 1;
    self.HUD.progress = progress;
    
    
    /* display complete screen */
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]] autorelease];
    HUD.detailsLabelText = nil;
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
    sleep(2);
    
    [self performUploadGIFController:self.filename];
    
    
}


/* generate a gif from a series of thumbnails */
- (IBAction)generateGIF:(id)sender {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.delegate = self;
    if( self.images.count != 0 ){
        
        /* display waiting screen and generate GIF */
       
        [self.navigationController.view addSubview:HUD];
        
        
        HUD.labelText = @"Preparing";
        //HUD.detailsLabelText = @"It will take about 5 seconds";
        [HUD showWhileExecuting:@selector(generateGIFfrompics) onTarget:self withObject:nil animated:YES];             
    }
    else{
        HUD.labelText = @"Fail to generate GIF";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
}




@end
