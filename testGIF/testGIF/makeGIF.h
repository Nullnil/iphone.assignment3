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
#import "ANGifBitmap.h"
#import "ANGifEncoder.h"
#import "ANImageBitmapRep.h"
#import "BitBuffer.h"
#import "ANGifPalette.h"
#import "ANPoint.h"



@interface testCameraViewController : UIViewController 
  <UIImagePickerControllerDelegate, UINavigationBarDelegate> {
    UIImageView *imageView;
    UIButton *takePhoto;
    UIButton *upload;
    NSMutableArray *times;
    NSMutableArray *images;
    UIImage *imageforpalette;
    NSString *filename;  
    UIButton *generate;
}

@property (nonatomic, retain) IBOutlet UIButton *generate;
@property(nonatomic,retain) NSMutableArray *times;

@property(nonatomic,retain) NSMutableArray *images;

@property (nonatomic,retain) UIImage *imageforpalette;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) IBOutlet NSString *filename;
@property (nonatomic, retain) IBOutlet UIButton *takePhoto;
@property (nonatomic, retain) IBOutlet UIButton *upload;

- (IBAction)uploadGIF:(id)sender;
- (IBAction)getPhoto:(id)sender;
- (IBAction)generateGIF:(id)sender;

@end
