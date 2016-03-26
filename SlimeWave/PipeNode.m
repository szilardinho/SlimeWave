//
//  PipeNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/28/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "PipeNode.h"

@implementation PipeNode

+(instancetype)pipeAtPosition:(CGPoint)position
{
    PipeNode *pipe = [self spriteNodeWithImageNamed:@"Pipe_1x2"];
    pipe.name = @"Pipe";
    pipe.position = position;
    pipe.zPosition = 3;
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"Pipe_2x2"],
                          [SKTexture textureWithImageNamed:@"Pipe_2x2"],
                          [SKTexture textureWithImageNamed:@"Pipe_2x2"],
                          [SKTexture textureWithImageNamed:@"Pipe_3x2"],
                          [SKTexture textureWithImageNamed:@"Pipe_1x2"]];
    
    SKAction *wait = [SKAction waitForDuration:0.45];

    SKAction *pipeAnimation = [SKAction animateWithTextures:textures timePerFrame:0.15];

    NSArray *sequence =  @[pipeAnimation,wait];
    
    [pipe runAction:[SKAction repeatActionForever:[SKAction sequence:sequence]]];
    
    return pipe;
   
}

@end
