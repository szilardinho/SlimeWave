//
//  GameOverNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 11/2/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "WallNode.h"
#import "Utility.h"

@implementation WallNode


+(instancetype)wallAtPosition:(CGPoint)position inFrame:(CGRect)frame
{
    WallNode *wall = [self spriteNodeWithColor:[SKColor clearColor] size:frame.size];
    wall.name = @"Wall1";
    wall.zPosition = 1;
    
    [wall setupPhysicsBody];
    
    return wall;
    
}
SKNode *leftWall = [SKNode node];
leftWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.height, 1)];
leftWall.physicsBody.categoryBitMask = wallCategory;
leftWall.physicsBody.affectedByGravity = NO;
leftWall.position = CGPointMake(0, self.size.height / 2);
[self addChild:leftWall];

SKNode *rightWall = [SKNode node];
rightWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.height, 1)];
rightWall.physicsBody.categoryBitMask = wallCategory;
rightWall.physicsBody.affectedByGravity = NO;
rightWall.position = CGPointMake(self.size.width, self.size.height / 2);
[self addChild:rightWall];


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
