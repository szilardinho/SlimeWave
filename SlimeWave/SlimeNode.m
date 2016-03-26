//
//  SlimeNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 11/2/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "SlimeNode.h"
#import "Utility.h"


@implementation SlimeNode

+(instancetype) slimeOfType:(SlimeType)type
{
    SlimeNode *slime;
    
    NSArray *textures;
    
    
    if (type == SlimeTypeA) {
        slime = [self  spriteNodeWithImageNamed:@"HickSlime_1x2"];
        textures = @[[SKTexture textureWithImageNamed:@"HickSlime_1x2"],
                     [SKTexture textureWithImageNamed:@"HickSlime_2x2"]];
    }else if (type == SlimeTypeB){
        slime = [self  spriteNodeWithImageNamed:@"MonsterSlime_2x2"];
        textures = @[[SKTexture textureWithImageNamed:@"MonsterSlime_1x2"],
                     [SKTexture textureWithImageNamed:@"MonsterSlime_2x2"]];
    }else if (type == SlimeTypeC){
        slime = [self spriteNodeWithImageNamed:@"SnakeSlime_1x2"],
        textures = @[[SKTexture textureWithImageNamed:@"SnakeSlime_2x2"],
                     [SKTexture textureWithImageNamed:@"SnakeSlime_1x2"]];
    }else if (type == SlimeTypeD){
        slime = [self spriteNodeWithImageNamed:@"ShockSlime_1x2"];
        textures = @[[SKTexture textureWithImageNamed:@"ShockSlime_2x2"],
                     [SKTexture textureWithImageNamed:@"ShockSlime_3x2"],
                     [SKTexture textureWithImageNamed:@"ShockSlime_1x2"]];
    }
    
    SKAction *animation  = [SKAction animateWithTextures:textures timePerFrame:0.5];
    [slime runAction:[SKAction repeatActionForever:animation]];
    
    [slime setupPhysicsBody];
    
    float scale = [Utility randomWithMin:50 max:51] / 100.0f;
    slime.xScale = scale;
    slime.yScale = scale;
    slime.zPosition = 2;
    
    return slime;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryGround | CollisionCategoryProjectile;
    
    //0010 | 1000 = 1010
}



@end
