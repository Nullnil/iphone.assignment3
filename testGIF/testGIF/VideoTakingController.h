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
#import "GenerateGIFController.h"


@interface VideoTakingController: UIViewController
  <UIImagePickerControllerDelegate> {
    NSMutableArray *times;
    NSMutableArray *images;
    UIImage *imageforpalette;
    NSString *filename;  
}

@property(nonatomic,retain) NSMutableArray *times;
@property(nonatomic,retain) NSString* filename;
@property(nonatomic,retain) NSMutableArray *images;
@property (nonatomic,retain) UIImage *imageforpalette;





@end
