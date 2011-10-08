//
//  ANPoint.h
//  Giraffe
//
//  Created by Matthew Klundt on 4/10/11.
//  Copyright 2011 Terrible Games. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ANPoint : NSObject {
    int r, g, b; // 0 - 255
}

@property (nonatomic) int r;
@property (nonatomic) int g;
@property (nonatomic) int b;

- (id) initWithR:(int)givenR withG:(int)givenG withB:(int)givenB;
- (id) initWithR:(int)givenR withG:(int)givenG withB:(int)givenB withA:(int)givenA withMatteR:(int)givenMR withMatteG:(int)givenG withMatteB:(int)givenB;

- (int) getR;
- (int) getG;
- (int) getB;

- (float) getDistanceFrom:(ANPoint*)givenPoint;

@end
