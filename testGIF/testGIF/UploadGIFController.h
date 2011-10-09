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

@interface uploadGIFController : UIViewController
{
    NSString *filename; 
    UIButton *shareToTumblr;
    MBProgressHUD *HUD;
}

@property(nonatomic,retain) NSString* filename;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) IBOutlet UIButton *shareToTumblr;

-(id)initWithFileName:(NSString*)name;
-(IBAction)uploadGIF:(id)sender;
- (void)hudWasHidden:(MBProgressHUD *)hud;



@end
