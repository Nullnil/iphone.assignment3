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
}

@property (nonatomic, retain) IBOutlet UITextField *password;

@property (nonatomic, retain) IBOutlet UITextField *userName;

- (IBAction)saveUserInfo:(id)sender;
- (IBAction)dismissKeyBoard:(id)sender;

@end
