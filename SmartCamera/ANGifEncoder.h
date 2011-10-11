//
//  ANGifEncoder.h
//  Giraffe
//
//  Created by Alex Nichol on 1/20/11.
//  Modified by Matthew Klundt on 4/12/11.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANGifBitmap.h"
#import "BitBuffer.h"

@class ANGifPalette;

@interface ANGifEncoder : NSObject {
	NSString * _fileName;
	NSFileHandle * _fileHandle;
	CGSize _size;
	float _delay;
	BOOL _animated;
	
	ANGifPalette *colorPalette;
}

@property (nonatomic, retain) ANGifPalette *colorPalette;

- (id)initWithFile:(NSString *)fileName withColorPalette:(ANGifPalette*)givenPalette animated:(BOOL)animated;
- (void)beginFile:(CGSize)size delayTime:(float)delay;
- (void)addImage:(ANGifBitmap *)bitmap;
- (void)endFile;

@end

@interface NSFileHandle (numbers)

- (void)writeASCII:(NSString *)asciiString;
- (void)writeLittleChar:(UInt8)tinyInt;
- (void)writeLittleShort:(UInt16)shortInt;
- (void)writeLittleInt:(UInt32)regInt;
- (void)writeLittleLong:(UInt64)longInt;

@end
