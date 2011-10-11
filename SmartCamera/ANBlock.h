//
//  ANBlock.h
//  Giraffe
//
//  Created by Matthew Klundt on 4/10/11.
//  Copyright 2011 Terrible Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANPoint;

@interface ANBlock : NSObject {
    ANPoint *minCorner, *maxCorner;
	
    NSMutableArray *points;
    int pointsLength;
	
	float longestSideLength;
}

@property (nonatomic, retain) ANPoint *minCorner;
@property (nonatomic, retain) ANPoint *maxCorner;

@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic) int pointsLength;

@property (nonatomic) float longestSideLength;

- (id) initWithPoints:(NSMutableArray *)givenArray;

- (float) getLongestSideLength;
- (int) getPointsCount;

@end
