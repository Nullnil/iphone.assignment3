//
//  ANGifPalette.m
//  Giraffe
//
//  Created by Matthew Klundt on 4/10/11.
//  Copyright 2011 Terrible Games. All rights reserved.
//

#import "ANGifPalette.h"
#import "ANPoint.h"
#import "ANBlock.h"

@implementation ANGifPalette

@synthesize matteColor, paletteArray;

- (id)initWithImage:(CGImageRef)imageRef withMatte:(ANPoint*)color {
	[super init];
	
	// save matte color
	[self setMatteColor:color];
	
	// create array for Point data
	NSMutableArray *allPointsArray = [[NSMutableArray alloc] initWithCapacity:1];
	
	// loop through imageRef bytes, add to array
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:imageRef];
    if (cgctx == NULL) { 
        // error creating context
        return nil;
    }
	
	// Get image width, height. We'll use the entire image.
    size_t w = CGImageGetWidth(imageRef);
    size_t h = CGImageGetHeight(imageRef);
    CGRect rect = {{0,0},{w,h}}; 
	
    CGContextDrawImage(cgctx, rect, imageRef); 
	
    unsigned char *data = CGBitmapContextGetData(cgctx);
    if (data != NULL) {
		int offset = 0;
		//int bytesTotal = w*h;
        int bytesTotal = 4*w*h;
		while (offset < bytesTotal) {
			int alpha =  data[offset]; 
			int red = data[offset+1]; 
			int green = data[offset+2]; 
			int blue = data[offset+3];
			
			if (alpha > 0) {
				// create ANPoint
				ANPoint *newPoint;
				if (alpha == 255) {
					newPoint = [[ANPoint alloc] initWithR:red withG:green withB:blue];
				} else {
					newPoint = [[ANPoint alloc] initWithR:red withG:green withB:blue withA:alpha withMatteR:color.r withMatteG:color.g withMatteB:color.b];
				}
				
				// add ANPoint to array
				[allPointsArray addObject:newPoint];
				
				// release
				[newPoint release];
			}
			
			// next offset
			offset += 32;
		}
		
	}
	
    // When finished, release the context
    CGContextRelease(cgctx); 
    // Free image data memory for the context
    if (data) {
        free(data);
    }
	
	// reduce initialPoints 
	NSMutableArray *firstPalette = [self cullDuplicatePoints:allPointsArray];
	if ([firstPalette count] > 254) { // 254 since the 255 spot is reserved for transparent
		//NSLog(@"firstPalette: %i", [firstPalette count]);
		paletteArray = [self medianCutPoints:allPointsArray];
	} else {
		[self setPaletteArray:firstPalette];
	}
	
	
	// readout of the final list
	/*NSLog(@"Total Indexes: %i", [paletteArray count]);
	for (int j = 0; j < [paletteArray count]; j++) {
		ANPoint *currentPoint = [paletteArray objectAtIndex:j];
		NSLog(@"Palette: %i %i %i", currentPoint.r, currentPoint.g, currentPoint.b);
	}*/
	
	// release 
	[allPointsArray release];
	[firstPalette release];
	
	return self;
}

- (UInt8) getIndexForColor:(ANPoint *)givenPixelInfo {
	UInt8 returnSmall = 0;
	float currentDistance = 256.0f;
	
	// loop through paletteArray
	int colorArrayCount = [paletteArray count];
	for (int i = 0; i < colorArrayCount; i++) {
		ANPoint *currentPoint = [paletteArray objectAtIndex:i];
		
		// get distance between colors
		float distance = [currentPoint getDistanceFrom:givenPixelInfo];
		
		// if distance is 0, return
		if (distance <= 0.000001f) {
			// close enough
			returnSmall = i;
			break;
		} else if (distance < currentDistance) {
			// else, save closest value to return
			currentDistance = distance;
			returnSmall = i;
		}
	}
	
	return returnSmall;
}

- (NSData *)getColorTable {
	// create a color table
	// containing a set of
	// 256 different colors.
	UInt8 bytes[3];
	NSMutableData * colorTable = [NSMutableData data];
	
	int colorArrayCount = [paletteArray count];
	for (int i = 0; true; i++) {
		if (i >= colorArrayCount) {
			// fill in extra indexes with black
			bytes[0] = 0;
			bytes[1] = 0;
			bytes[2] = 0;
		} else {
			ANPoint *currentPoint = [paletteArray objectAtIndex:i];
			
			// get bytes
			UInt8 red = currentPoint.r; //(i & 3) * 64;
			UInt8 green = currentPoint.g; //((i >> 2) & 3) * 64;
			UInt8 blue = currentPoint.b; //((i >> 4) & 3) * 64;
			
			//NSLog(@"%d %d %d", red, green, blue);
			//NSLog(@"Shift: %d", (i >> 2));
			
			bytes[0] = red;
			bytes[1] = green;
			bytes[2] = blue;
		}
		
		// create the RGB
		[colorTable appendBytes:bytes length:3];
		if (i == 255) break;
	}
	
	return colorTable;
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
	
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
	size_t pixelsWide = CGImageGetWidth(inImage);
	size_t pixelsHigh = CGImageGetHeight(inImage);
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this example is represented by 4 bytes; 8 bits each of red, green, blue, and alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	if (colorSpace == NULL) {
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL) {
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits per component. Regardless of what the source image format is (CMYK, Grayscale, and so on) it will be converted over to the format specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedFirst);
	if (context == NULL) {
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}

- (NSMutableArray *) cullDuplicatePoints:(NSMutableArray *)givenArray {
	
	if ([givenArray count] < 1) {
		return nil;
	}
	
	// eliminate duplicate palette indexes
	NSMutableArray *combinedPalette = [[NSMutableArray alloc] initWithCapacity:1];
	[combinedPalette addObject:[givenArray objectAtIndex:0]];
	
	int givenCount = [givenArray count];
	for (int i = 1; i < givenCount; i++) {
		ANPoint *currentPoint = [givenArray objectAtIndex:i];
		bool addPoint = true;
		
		// loop through combinedPalette and don't add if dist == 0
		for (int j = 0; j < [combinedPalette count]; j++) {
			if ([currentPoint getDistanceFrom:[combinedPalette objectAtIndex:j]] < 0.000001f) {
				addPoint = false;
				
				// exit loop
				break;
			}
		}
		
		if (addPoint) {
			[combinedPalette addObject:currentPoint];
		}
	}
	
	return combinedPalette;
}

- (NSMutableArray *) medianCutPoints:(NSMutableArray *)givenArray {
	
	// take pointArray and create a block
	ANBlock *initialBlock = [[ANBlock alloc] initWithPoints:givenArray];
	
	// create queue
	NSMutableArray *blockQueue = [[NSMutableArray alloc] init];
	[blockQueue addObject:initialBlock];
	
	// main loop through block until enough palettes are created
	while ([blockQueue count] < 254) {
		// save and pop first object
		ANBlock *longestBlock = [blockQueue objectAtIndex:0];
		
		//NSLog(@"Longest Side: %f", [longestBlock getLongestSideLength]);
		
		//split longestBlock into block1 and block2
		NSMutableArray *splitArray = [[NSArray alloc] initWithArray:longestBlock.points];
		int halfInt = [splitArray count]/2;
		int totalCount = [splitArray count];
		NSMutableArray *firstHalf = [[NSMutableArray alloc] initWithArray:[splitArray subarrayWithRange:NSMakeRange(0, halfInt)]];
		NSMutableArray *lastHalf = [[NSMutableArray alloc] initWithArray:[splitArray subarrayWithRange:NSMakeRange(halfInt, totalCount - halfInt)]];
		
		// create new blocks from arrays of the split
		ANBlock *newBlock1 = [[ANBlock alloc] initWithPoints:firstHalf];
		ANBlock *newBlock2 = [[ANBlock alloc] initWithPoints:lastHalf];
		
		// add the two new blocks back in
		[blockQueue removeObjectAtIndex:0];
		[blockQueue addObject:newBlock1];
		[blockQueue addObject:newBlock2];
		
		// sort by longest length
		[blockQueue sortUsingSelector:@selector(longestSideSort:)];
		
		// release
		[splitArray release];
		[newBlock1 release];
		[newBlock2 release];
		[firstHalf release];
		[lastHalf release];
	}
	
	// get average value for each block in queue
	NSMutableArray *averagePoints = [[NSMutableArray alloc] initWithCapacity:1];
	int queueCount = [blockQueue count];
	for (int i=0; i < queueCount; i++) {
		// get currentBlock reference
		ANBlock *currentBlock = [blockQueue objectAtIndex:i];
		
		float rSum = 0.0f;
		float gSum = 0.0f;
		float bSum = 0.0f;
		
		// loop through points in currentBlock
		for (int j=0; j < currentBlock.pointsLength; j++) {
			ANPoint *currentPoint = [currentBlock.points objectAtIndex:j];
			
			rSum += (float)[currentPoint getR];
			gSum += (float)[currentPoint getG];
			bSum += (float)[currentPoint getB];
		}
		
		// create point from average value
		float pointsCount = currentBlock.pointsLength;
		ANPoint *averagePoint = [[ANPoint alloc] initWithR:rSum/pointsCount withG:gSum/pointsCount withB:bSum/pointsCount];
		
		// add to array
		[averagePoints addObject:averagePoint];
		
		// release
		[averagePoint release];
	}
	
	// release
	[blockQueue release];
	[initialBlock release];
	
	return averagePoints;
}

- (void) dealloc {
	[matteColor release];
	
	[paletteArray removeAllObjects];
	[paletteArray release];
	
	[super dealloc];
}

@end
