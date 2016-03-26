//
//  LaserBlastNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/29/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "LaserBlastNode.h"
#import "Utility.h"

@implementation LaserBlastNode

+(instancetype)laserBlastAtPosition: (CGPoint)position
{
    LaserBlastNode *laserBlast = [self spriteNodeWithImageNamed:@"LaserBlast_1"];
    laserBlast.position = position;
    laserBlast.zPosition = 2;
    laserBlast.name = @"LaserBlast";
    
    [laserBlast setUpAnimation];
    [laserBlast setUpPhysicsBody];
    
    return laserBlast;
}

-(void)setUpAnimation
{
    NSArray *textures  = @[[SKTexture textureWithImageNamed:@"LaserBlast_2"],
                           [SKTexture textureWithImageNamed:@"LaserBlast_3"],
                           [SKTexture textureWithImageNamed:@"LaserBlast_1"]];
    SKAction *laserBlastAnimation = [SKAction animateWithTextures:textures timePerFrame:0.05];
//    SKAction *rotate = [SKAction rotateByAngle:90 duration:10000];
    ///FINSIH THIS CODE!
    //Create two invsible nodes that the laserblast comes from!
    SKAction *repeatAnimation = [SKAction repeatActionForever:laserBlastAnimation];
    [self runAction:repeatAnimation];
}

-(void)setUpPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}

-(void)moveTowardsPosition:(CGPoint)position
{ // slope = (Y3 - Y1) / (X3 - X1)
    float slope = (position.y - self.position.y ) / (position.x - self.position.x);
    
    //slope = (Y2- Y1) / (X2 - X1)
    //Y2 - Y1  = slope (X2 - X1)
    //Y2  = slope * X2 - slope * X1 + Y1
    
    float offScreenX;
    
    if (position.x <= self.position.x)
    {
        offScreenX = -10;
    }else{
        offScreenX = self.parent.frame.size.width + 10;
    }
    
    float offScreenY = slope * offScreenX - slope * position.x + self.position.y;
    
    CGPoint pointOffScreen = CGPointMake(offScreenX,offScreenY);
    
    float distanceA = pointOffScreen.y - self.position.y;
    float distanceB = pointOffScreen.x - self.position.x;
    
    float distanceC =sqrtf(powf(distanceA, 2)+ powf(distanceB, 2));
    
    //distance = speed * time
    //time = distance/speed
    
    float time = distanceC / 400; //constant-----LaserBlastSpeed
    float waitToFade = time  * 0.75;
    float fadeTime = time  - waitToFade;
    
    SKAction *moveProjectile  = [SKAction moveTo:pointOffScreen duration:time];
    [self runAction:moveProjectile];
    
    NSArray *sequence  = @[[SKAction waitForDuration:waitToFade],
                           [SKAction fadeOutWithDuration:fadeTime],
                           [SKAction removeFromParent]];
    
    [self runAction:[SKAction sequence:sequence]];
    
}



@end
