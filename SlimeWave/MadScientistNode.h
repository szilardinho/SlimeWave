//
//  MadScientistNode.h
//  SlimeWave
//
//  Created by Szi Gabor on 10/27/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MadScientistNode : SKSpriteNode

+(instancetype)madScientistAtPosition: (CGPoint)position;
-(void)performTap;
@end
