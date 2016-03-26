//
//  SplashNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/28/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "SplashNode.h"

@implementation SplashNode

+(instancetype)splashAtPosition:(CGPoint)position
{
    SplashNode *splash = [self spriteNodeWithImageNamed:@"Splash_1x2"];
    splash.name = @"Waterfall";
    splash.position = position;
    splash.zPosition = 1;
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"Splash_2x2"],
                          [SKTexture textureWithImageNamed:@"Splash_1x2"]];
    
    //    SKAction *wait = [SKAction waitForDuration:0.45];
    
    SKAction *splashAnimation = [SKAction animateWithTextures:textures timePerFrame:0.25];
    
    NSArray *sequence =  @[splashAnimation];
    
    [splash runAction:[SKAction repeatActionForever:[SKAction sequence:sequence]]];
    
    return splash;
    
}

@end
