//
//  MyMapAnnotation.m
//  InShanghai
//
//  Created by zucknet on 13/3/13.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "MyMapAnnotation.h"

@implementation MyMapAnnotation

@synthesize title;
@synthesize coordinate;
@synthesize subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

@end
