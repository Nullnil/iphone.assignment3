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

@interface VideoTakingController: UIViewController
  <UIImagePickerControllerDelegate> {
    NSMutableArray *times;
    NSMutableArray *images;
    UIImage *imageforpalette;
    NSString *filename;
    NSString *weather;
    MBProgressHUD *HUD;
    UIImageView *imageView;
    UIButton *generategifbutton;
}

@property(nonatomic, retain) NSString *weather;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property(nonatomic,retain) NSMutableArray *times;
@property(nonatomic,retain) NSString* filename;
@property(nonatomic,retain) NSMutableArray *images;
@property (nonatomic,retain) UIImage *imageforpalette;
@property (nonatomic, retain) IBOutlet UIButton *generategifbutton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;


-(IBAction)generateGIF:(id)sender;
- (void)hudWasHidden:(MBProgressHUD *)hud;


@end
