//
//  Setting.h
//  SmartCamera
//
//  Created by sen hou on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManager.h"

@interface Setting : UIViewController {
    IBOutlet UITextField *userName;
    IBOutlet UITextField *password;
    NSMutableArray *arrayColours;
    NSMutableArray *arrayBackgrounds;
    UIPickerView *ColourPicker;
}

@property (nonatomic, retain) NSMutableArray *arrayColours;
@property (nonatomic, retain) NSMutableArray *arrayBackgrounds;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UIPickerView *ColourPicker;
@property (nonatomic, retain) IBOutlet UITextField *userName;

- (IBAction)saveUserInfo:(id)sender;
- (IBAction)dismissKeyBoard:(id)sender;

@end
