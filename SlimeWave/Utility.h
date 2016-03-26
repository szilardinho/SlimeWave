//
//  Utility.h
//  SlimeWave
//
//  Created by Szi Gabor on 10/31/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int LaserBlastSpeed = 400;
static const int SlimeMinimumSpeed = -120;
static const int SlimeMaximumSpeed = -130;
static const int NumberOfLives = 3.0;
static const int PointsPerHit = 100;

typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CollisionCategoryEnemy              = 1 << 0,     //0000
    CollisionCategoryProjectile         = 1 << 1,     //0010
    CollisionCategoryDebris             = 1 << 2,     //0100
    CollisionCategoryGround             = 1 << 3,     //1000
    CollisionCategoryWall               = 1 << 4,    //10000
    CollisionCategoryWorld              = 1 << 5   // 100000
};


@interface Utility : NSObject

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max;


@end
