//
//  GiraffeViewController.h
//  Giraffe
//
//  Created by Alex Nichol on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiraffeViewController : UIViewController {
	UILabel *timeLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

- (IBAction) createGIFImage:(id)sender;

- (void) convert;

@end

