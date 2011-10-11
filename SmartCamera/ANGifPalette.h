//
//  ANGifPalette.h
//  Giraffe
//
//  Created by Matthew Klundt on 4/10/11.
//  Copyright 2011 Terrible Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PixelColorInfo;
@class ANPoint;

@interface ANGifPalette : NSObject {
	ANPoint *matteColor;
    NSMutableArray *paletteArray;
}

@property (nonatomic, retain) ANPoint *matteColor;
@property (nonatomic, retain) NSMutableArray *paletteArray;

- (id)initWithImage:(CGImageRef)imageRef withMatte:(ANPoint*)color;

- (UInt8) getIndexForColor:(ANPoint *)givenPixelInfo;

- (NSData *)getColorTable;
- (NSMutableArray *) cullDuplicatePoints:(NSMutableArray *)givenArray;
- (NSMutableArray *) medianCutPoints:(NSMutableArray *)givenArray;

@end
