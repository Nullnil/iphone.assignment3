//
//  ANBlock.m
//  Giraffe
//
//  Created by Matthew Klundt on 4/10/11.
//  Copyright 2011 Terrible Games. All rights reserved.
//

#import "ANBlock.h"
#import "ANPoint.h"

@implementation ANBlock

@synthesize minCorner, maxCorner, points, pointsLength, longestSideLength;

- (id) initWithPoints:(NSMutableArray *)givenArray {
	self = [super init];
	
	[self setPoints:givenArray];
    pointsLength = [points count];
	
	ANPoint *newminCorner = [[ANPoint alloc] initWithR:[[givenArray objectAtIndex:0] getR] withG:[[givenArray objectAtIndex:0] getG] withB:[[givenArray objectAtIndex:0] getB]];
	[self setMinCorner:newminCorner];
	[newminCorner release];
	
	ANPoint *newmaxCorner = [[ANPoint alloc] initWithR:[[givenArray objectAtIndex:0] getR] withG:[[givenArray objectAtIndex:0] getG] withB:[[givenArray objectAtIndex:0] getB]];
	[self setMaxCorner:newmaxCorner];
	[newmaxCorner release];
	
	// find min and max of r,g,b
	for (int i=1; i < pointsLength; i++) {
		// find min's
		if (minCorner.r > [[givenArray objectAtIndex:i] getR]) minCorner.r = [[givenArray objectAtIndex:i] getR];
		if (minCorner.g > [[givenArray objectAtIndex:i] getG]) minCorner.g = [[givenArray objectAtIndex:i] getG];
		if (minCorner.b > [[givenArray objectAtIndex:i] getB]) minCorner.b = [[givenArray objectAtIndex:i] getB];
		
		// find max's
		if (maxCorner.r < [[givenArray objectAtIndex:i] getR]) maxCorner.r = [[givenArray objectAtIndex:i] getR];
		if (maxCorner.g < [[givenArray objectAtIndex:i] getG]) maxCorner.g = [[givenArray objectAtIndex:i] getG];
		if (maxCorner.b < [[givenArray objectAtIndex:i] getB]) maxCorner.b = [[givenArray objectAtIndex:i] getB];
	}
	
	// find longest side length
	int sortBy = 0;
	longestSideLength = maxCorner.r - minCorner.r;
	if (maxCorner.g - minCorner.g > longestSideLength) {
		longestSideLength = maxCorner.g - minCorner.g;
		sortBy = 1;
	}
	if (maxCorner.b - minCorner.b > longestSideLength) {
		longestSideLength = maxCorner.b - minCorner.b;
		sortBy = 2;
	}
	
	// sort points by the longest value
	switch (sortBy) {
		case 1:
			[points sortUsingSelector:@selector(gSort:)];
			break;
		case 2:
			[points sortUsingSelector:@selector(bSort:)];
			break;
		default:
			[points sortUsingSelector:@selector(rSort:)];
			break;
	}
	
	return self;
}

- (float) getLongestSideLength {
    return longestSideLength;
}

- (int) getPointsCount {
	return pointsLength;
}

- (NSComparisonResult) longestSideSort:(ANBlock*) other {
	if (self->longestSideLength > other->longestSideLength) return NSOrderedAscending;
	if (self->longestSideLength < other->longestSideLength) return NSOrderedDescending;
	
	// The logical thing to do at this point is to return NSOrderedSame, but that causes flickering when two items are overlapping at the same y.
	// Instead,one must be drawn over the other deterministically... we use the memory addresses of the entities for a tie-breaker.
	if (self->pointsLength > other->pointsLength) return NSOrderedAscending;
	return NSOrderedDescending;
}

- (void) dealloc {
	//NSLog(@"ANBlock dealloc");
	
	[minCorner release];
	[maxCorner release];
	
	[points release];
	
	[super dealloc];
}

@end
