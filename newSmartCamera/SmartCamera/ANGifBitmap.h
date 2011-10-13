//
//  ANGifBitmap.h
//  Giraffe
//
//  Created by Alex Nichol on 1/20/11.
//  Modified by Matthew Klundt on 4/12/11.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANImageBitmapRep.h"

@class ANGifPalette;

@interface ANGifBitmap : NSObject {
	ANImageBitmapRep *imageBitmap;
	ANGifPalette *colorPalette;
}

@property (nonatomic, retain) ANGifPalette *colorPalette;

- (id)initWithImage:(UIImage *)image withColorPalette:(ANGifPalette*)givenPalette;
- (CGSize)size;
- (UInt32)getPixel:(CGPoint)pt;
- (NSData *)smallBitmapData;

@end
