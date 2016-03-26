//
//  GameData.m
//  SlimeWave
//
//  Created by Szi Gabor on 12/17/15.
//  Copyright © 2015 Szi Gabor. All rights reserved.
//

#import "GameData.h"


@implementation GameData

+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(void)reset
{
    self.score = 0;
    self.survivalTime = 0;
}

@end
