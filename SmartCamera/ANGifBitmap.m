//
//  ANGifBitmap.m
//  Giraffe
//
//  Created by Alex Nichol on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANGifBitmap.h"
#import "ANGifPalette.h"
#import "ANPoint.h"

static UInt8 make3 (UInt8 m) {
	if (m >= 4) m = 3;
	return m;
}

@implementation ANGifBitmap

@synthesize colorPalette;

- (id)initWithImage:(UIImage *)image withColorPalette:(ANGifPalette*)givenPalette {
	if (self = [super init]) {
		imageBitmap = [[ANImageBitmapRep alloc] initWithImage:image];
		[self setColorPalette:givenPalette];
	}
	return self;
}

- (CGSize)size {
	return [imageBitmap size];
}

- (UInt32)getPixel:(CGPoint)pt {
	UInt32 pixel = 0;
	[imageBitmap get255Pixel:(char *)(&pixel) atX:(int)(pt.x) y:(int)(pt.y)];
	return pixel;
}

- (NSData *)smallBitmapData {
	// go through and get every single pixel, 
	// then turn it into one byte/pixel
	NSMutableData * returnData = [NSMutableData data];
	CGSize s = [self size];
	int width = (int)s.width;
	int height = (int)s.height;
	
	for (int y = 0; y < height; y++) {
		for (int x = 0; x < width; x++) {
			// read the information
			NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
			
			//NSLog(@"Reading: %d, %d", x, y);
			UInt32 pixel = [self getPixel:CGPointMake(x,y)];
			
			unsigned char *pxlData = (unsigned char *)&pixel;
			//NSLog(@"Done.");
			
			// Let's figure out the color values
			int r = (int)pxlData[1];
			int g = (int)pxlData[2];
			int b = (int)pxlData[3];
			int a = (int)pxlData[0];
			
			ANPoint *currentColor;
			if (a == 255) {
				currentColor = [[ANPoint alloc] initWithR:r withG:g withB:b];
			} else if (a > 0) {
				// get pixel color for the partially transparent, with matte background added
				currentColor = [[ANPoint alloc] initWithR:r withG:g withB:b withA:a withMatteR:colorPalette.matteColor.r withMatteG:colorPalette.matteColor.g withMatteB:colorPalette.matteColor.b];
			}
			
			// now we need to find the closest palette index
			UInt8 small = 0;
			
			if (a > 0) { 
				int paletteIndex = [colorPalette getIndexForColor:currentColor];
				
				small = (UInt8)paletteIndex;
				
				[currentColor release];
				//NSLog(@"Pixel rgb: %i %i %i %i :index: %i", r, g, b, a, paletteIndex);
			} else {
				// The last index (255) is reserved for completely transparent pixels
				small = 255;
			}
			
			
			[returnData appendBytes:&small length:1];
			//NSLog(@"Size: %d", [returnData length]);
			
			[pool drain];
			//NSLog(@"Done freepool.");
		}
	}
	
	//NSLog(@"Done conversion.");
	
	return returnData;
}

- (void)dealloc {
	[imageBitmap release];
	[colorPalette release];
	
	[super dealloc];
}

@end
