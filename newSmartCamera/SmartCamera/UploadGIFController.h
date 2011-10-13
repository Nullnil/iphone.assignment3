//
//  GenerateGIFController.h
//  testGIF
//
//  Created by Le Yan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD.h"
#import "loginView.h"
#import "Weather.h"
#import "FileManager.h"

@interface UploadGIFController : UIViewController<UIViewPassUserInfoeDelegate>
{
    NSString *filename; 
    NSString *username;
    NSString *password;
    MBProgressHUD *HUD;
    Weather *weather;

    UIButton *shareToTumblr;
    UISwitch *swith;
    UITextField *textField;
}



@property (nonatomic, retain) IBOutlet UITextField *textField;
@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString* filename;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) IBOutlet UIButton *shareToTumblr;
@property (nonatomic, retain) Weather *weather;
@property (nonatomic, retain) IBOutlet UISwitch *swith;


- (IBAction)dissmissKeyboard:(id)sender;

-(id)initWithFileName:(NSString*)name 
           andWeather:(Weather*)weatherInfo;

- (IBAction)share:(id)sender;

- (void)hudWasHidden:(MBProgressHUD *)hud;

- (void)passUserInfo:(NSString*)usrname password:(NSString*)pass; 


@end
