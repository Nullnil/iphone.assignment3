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


@interface uploadGIFController : UIViewController<UIViewPassUserInfoeDelegate>
{
    NSString *filename; 
    UIButton *shareToTumblr;
    NSString *username;
    NSString *password;
    MBProgressHUD *HUD;
    NSString *weather;
}


@property(nonatomic,retain) NSString *weather;
@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString* filename;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) IBOutlet UIButton *shareToTumblr;

-(id)initWithFileName:(NSString*)name 
           andWeather:(NSString*)weatherInfo;

- (IBAction)share:(id)sender;
- (void)hudWasHidden:(MBProgressHUD *)hud;
- (void)passUserInfo:(NSString*)usrname password:(NSString*)pass; 


@end
