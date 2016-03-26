//
//  Utility.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/31/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max
{
    return arc4random()% (max - min) + min;
}

@end
