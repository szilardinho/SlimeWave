//
//  SewerRiverNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/27/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "SewerRiverNode.h"

@implementation SewerRiverNode

+(instancetype)sewerRiverAtPosition:(CGPoint)position
{
    SewerRiverNode *sewerRiver = [self spriteNodeWithImageNamed:@"SewerRiver_1x2"];
    sewerRiver.name = @"SewerRiver";
    sewerRiver.position = position;
    sewerRiver.zPosition = 1;
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"SewerRiver_1x2"],
                          [SKTexture textureWithImageNamed:@"SewerRiver_2x2"],
                           [SKTexture textureWithImageNamed:@"SewerRiver_3x2"]];
    
            SKAction *sewerRiverAnimation = [SKAction animateWithTextures:textures timePerFrame:0.4];
            SKAction *repeatAnimation = [SKAction repeatActionForever:sewerRiverAnimation];
    
            [sewerRiver runAction:repeatAnimation];

    return sewerRiver;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
}

@end
