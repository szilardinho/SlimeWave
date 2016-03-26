//
//  GroundNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 11/2/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "GroundNode.h"
#import "Utility.h"

@implementation GroundNode

+(instancetype)groundWithSize:(CGSize)size
{
    GroundNode *ground = [self spriteNodeWithColor:[SKColor clearColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width/2, size.height/2);
    ground.zPosition = 1;
    
    [ground setupPhysicsBody];
    
    return ground;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryGround;
    self.physicsBody.collisionBitMask = CollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}

@end
