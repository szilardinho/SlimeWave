//
//  HUDNode.m
//  SlimeWave
//
//  Created by Szi Gabor on 11/2/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "HUDNode.h"
#import "Utility.h"


@implementation HUDNode

+(instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame
{
    HUDNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 4;
    hud.name = @"HUD";
    
    SKSpriteNode *scientistHead = [SKSpriteNode spriteNodeWithImageNamed:@"LifeHud_1"];
    scientistHead.position = CGPointMake(CGRectGetMidX(frame)-30, -30);
    [hud addChild:scientistHead];
    
    hud.lives = NumberOfLives;
    
    SKSpriteNode *lastLifeBar;
    
    for (int i = 0; i < hud.lives; i++) {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"LifeHUD_2"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d", i+1];
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil)
        {
            lifeBar.position = CGPointMake(scientistHead.position.x + 50, scientistHead.position.y);
        }else
        {
            lifeBar.position = CGPointMake(lastLifeBar.position.x + 30, lastLifeBar.position.y);
        }
        
        lastLifeBar = lifeBar;
    }
    
   SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width - 20, -10);
    [hud addChild:scoreLabel];
    
    return hud;
}

-(void)addPoints:(NSInteger)points
{
    self.score += points;
    
   SKLabelNode *scoreLabel = (SKLabelNode *) [self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)self.score];
}

-(BOOL)loseLife
{
    if (self.lives > 0) {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%ld",(long)self.lives];
        SKNode *lifeToRemove = [self childNodeWithName:lifeNodeName];
        [lifeToRemove removeFromParent];
        self.lives--;
    }
    
    return self.lives == 0;
}


@end
