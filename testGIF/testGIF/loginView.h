//
//  loginView.h
//  testGIF
//
//  Created by Le Yan on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/* pass user info like username and password */
@protocol UIViewPassUserInfoeDelegate  
- (void)passUserInfo:(NSString*)usrname password:(NSString*)pass; 
-(void)sharetoTumblr;
@end 


@interface loginView : UIViewController {
    UITextField *password;
    UITextField *username;
    NSObject<UIViewPassUserInfoeDelegate> *delegate;  
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password; 
@property (nonatomic, retain)  NSObject<UIViewPassUserInfoeDelegate> *delegate;

- (IBAction)login:(id)sender;

- (IBAction)cancel:(id)sender;

@end
