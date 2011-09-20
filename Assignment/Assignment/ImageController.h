//
//  FirstViewController.h
//  Assignment
//
//  Created by sen hou on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageController : UIViewController <UIImagePickerControllerDelegate>{
    
    UIButton *cameraButton;
    UIButton *photoButton;
    UIImageView *imageView;
}
@property (nonatomic, retain) IBOutlet UIButton *cameraButton;
@property (nonatomic, retain) IBOutlet UIButton *photoButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (IBAction)choosePhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;

@end
