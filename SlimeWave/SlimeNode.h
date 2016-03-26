//
//  SlimeNode.h
//  SlimeWave
//
//  Created by Szi Gabor on 11/2/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, SlimeType) {
    SlimeTypeA = 0,
    SlimeTypeB = 1,
    SlimeTypeC = 2,
    SlimeTypeD = 3
    
};

@interface SlimeNode : SKSpriteNode

+(instancetype) slimeOfType:(SlimeType)type;

@end
