//
//  testCameraViewController.h
//  testCamera
//
//  Created by Le Yan on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <unistd.h>
#import "UploadGIFController.h"
#import "ANGifBitmap.h"
#import "ANGifEncoder.h"
#import "ANImageBitmapRep.h"
#import "BitBuffer.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ANGifPalette.h"
#import "ANPoint.h"
#import "MBProgressHUD.h"
#import "Weather.h"
#import "WeatherReport.h"
#import "PhotoData.h"
#import "Photo.h"

#import "SmartCameraAppDelegate.h"

@interface VideoTakingController: UIViewController <UIImagePickerControllerDelegate,WeatherDelegate> {
    NSMutableArray *times;
    NSMutableArray *images;
    UIImage *imageforpalette;
    NSString *filename;  
    MBProgressHUD *HUD;
    UIImageView *imageView;
    UIButton *generategifbutton;
    Weather *weather;
    WeatherReport *weatherReport;
    BOOL hasLoaded;
    
    NSManagedObjectContext *managedObjectContext;
    UITextField *imageTitle;
    UILabel *imageLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *imageLabel;
@property (nonatomic, retain) IBOutlet UITextField *imageTitle;
- (IBAction)dismissKeyBoard:(id)sender;

@property (nonatomic, retain) MBProgressHUD *HUD;
@property(nonatomic,retain) NSMutableArray *times;
@property(nonatomic,retain) NSString* filename;
@property(nonatomic,retain) NSMutableArray *images;
@property (nonatomic,retain) UIImage *imageforpalette;
@property (nonatomic, retain) IBOutlet UIButton *generategifbutton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) Weather *weather;
@property (nonatomic, retain) WeatherReport* weatherReport;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;;


-(IBAction)generateGIF:(id)sender;
- (void)hudWasHidden:(MBProgressHUD *)hud;

- (void)savePhotoData:(PhotoData*)photoData;

- (void)WeatherReport:(WeatherReport *)loadData weatherFinished:(Weather *) weather;

- (void) alert:(NSString*)message;
@end
