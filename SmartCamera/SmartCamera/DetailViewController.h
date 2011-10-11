//
//  DetailViewController.h
//  SmartCamera
//
//  Created by sen hou on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Photo.h"

@interface DetailViewController : UIViewController{
    Photo *photo;
    IBOutlet UITextField *temperature;
    IBOutlet UITextField *description;
    IBOutlet UIWebView *webView;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UITextField *description;
@property (nonatomic, retain) IBOutlet UITextField *temperature;
@property (nonatomic, retain) Photo *photo ;

@end
