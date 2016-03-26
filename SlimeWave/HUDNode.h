//
//  HUDNode.h
//  SlimeWave
//
//  Created by Szi Gabor on 11/2/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface HUDNode : SKSpriteNode


@property(nonatomic)NSInteger lives;
@property(nonatomic)NSInteger score;

//+(instancetype)sharedGameData;
+(instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;
-(void)addPoints: (NSInteger)points;
-(BOOL)loseLife;

@end
