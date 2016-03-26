//
//  GameData.h
//  SlimeWave
//
//  Created by Szi Gabor on 12/17/15.
//  Copyright © 2015 Szi Gabor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (assign, nonatomic) double score;
@property (assign, nonatomic) double survivalTime;

@property (assign, nonatomic) double highScore;

+(instancetype)sharedGameData;
-(void)reset;


@end
