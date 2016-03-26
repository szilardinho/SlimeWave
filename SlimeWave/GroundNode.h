//
//  GroundNode.h
//  SlimeWave
//
//  Created by Szi Gabor on 11/2/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GroundNode : SKSpriteNode

+(instancetype)groundWithSize:(CGSize)size;
-(void)setupPhysicsBody;

@end
