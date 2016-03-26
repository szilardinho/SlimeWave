//
//  WaterfallNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/28/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "WaterfallNode.h"

@implementation WaterfallNode

+(instancetype)waterfallAtPosition:(CGPoint)position
{
    WaterfallNode *waterfall = [self spriteNodeWithImageNamed:@"Waterfall_1x2"];
    waterfall.name = @"Waterfall";
    waterfall.position = position;
    waterfall.zPosition = 1;
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"Waterfall_1x2"],
                          [SKTexture textureWithImageNamed:@"Waterfall_2x2"],
                          [SKTexture textureWithImageNamed:@"Waterfall_3x2"],];
    
//    SKAction *wait = [SKAction waitForDuration:0.45];
    
    SKAction *waterfallAnimation = [SKAction animateWithTextures:textures timePerFrame:0.25];
    
    NSArray *sequence =  @[waterfallAnimation];
    
    [waterfall runAction:[SKAction repeatActionForever:[SKAction sequence:sequence]]];
    
    return waterfall;

    
}

@end
