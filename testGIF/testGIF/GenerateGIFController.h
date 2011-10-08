//
//  GenerateGIFController.h
//  testGIF
//
//  Created by Le Yan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGifBitmap.h"
#import "ANGifEncoder.h"
#import "ANImageBitmapRep.h"
#import "BitBuffer.h"
#import "ANGifPalette.h"
#import "ANPoint.h"

@interface GenerateGIFController : UIViewController
{
    NSMutableArray *images;
    UIImage *imageforpalette;
    UIImageView *imageView;
    NSString *filename;  
}

@property(nonatomic,retain) NSMutableArray *images;
@property (nonatomic,retain) UIImage *imageforpalette;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) NSString *filename;


-(NSString*)generateNewGifName;
-(IBAction)generateGIF:(id)sender;
-(id)initWithThumbnails:(NSMutableArray *)uiImages imageforpalette:(UIImage *) palette;


@end
