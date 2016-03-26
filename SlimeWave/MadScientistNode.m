//
//  MadScientistNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/27/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "MadScientistNode.h"
@interface MadScientistNode()
@property (nonatomic)  SKAction *tapAction;
@end

@implementation MadScientistNode

+(instancetype)madScientistAtPosition:(CGPoint)position
{
    MadScientistNode *madScientist = [self spriteNodeWithImageNamed:@"MadScientistGunsDrawnx2"];
    madScientist.position = position;
    madScientist.zPosition = 3;
    madScientist.name = @"MadScientist";
    
//        NSArray *textures = @[[SKTexture textureWithImageNamed:@"MadScientistGunsFirex2"],
//                              [SKTexture textureWithImageNamed:@"MadScientistGunsDrawnx2"]];
//    
//        SKAction *madScientistAnimation = [SKAction animateWithTextures:textures timePerFrame:0.8];
//        SKAction *repeatAnimation = [SKAction repeatActionForever:madScientistAnimation];
//    
//        [madScientist runAction:repeatAnimation]; //<-----Auto-animate Scientist without user involvement
    
    return madScientist;
}

-(void)performTap
{
    [self runAction:self.tapAction];
}

-(SKAction *) tapAction
{
    if (_tapAction != nil) {
        return _tapAction;
    }
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"MadScientistGunsFirex2"],
                          [SKTexture textureWithImageNamed:@"MadScientistGunsDrawnx2"]];
    
    _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    return _tapAction;
}

@end


