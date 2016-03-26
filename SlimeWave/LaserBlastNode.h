//
//  LaserBlastNode.h
//  SlimeWave
//
//  Created by Szi Gabor on 10/29/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LaserBlastNode : SKSpriteNode

+(instancetype)laserBlastAtPosition: (CGPoint)position;
-(void)moveTowardsPosition:(CGPoint)position;


@end
