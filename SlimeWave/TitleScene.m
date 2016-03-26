//
//  TitleScene.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/26/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"
#import <AVFoundation/AVFoundation.h>


@interface TitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end


@implementation TitleScene


-(void)didMoveToView:(SKView *)view
{
    /* Setup your scene here */
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"TitleScene"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    background.size = self.frame.size;
    background.zPosition = 0;
    [self addChild:background];
    

    
    self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"titleSceneMusic" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
    [self.backgroundMusic play];
    
    SKLabelNode *tapToPlayLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    tapToPlayLabel.text = @"Tap to Play";
    tapToPlayLabel.fontSize = 30;
    tapToPlayLabel.fontColor = [SKColor whiteColor];
    tapToPlayLabel.position = CGPointMake(CGRectGetMidX(self.frame), 350);
    tapToPlayLabel.zPosition = 1;
    
    SKAction *labelTransition = [SKAction fadeOutWithDuration:1.2];
    SKAction *labelTransition2= [SKAction fadeInWithDuration:1.2];
    NSArray *sequence =  @[labelTransition,labelTransition2];
    
    [tapToPlayLabel runAction:[SKAction repeatActionForever:[SKAction sequence:sequence]]];
    [self addChild:tapToPlayLabel];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self runAction:self.pressStartSFX];
    [self.backgroundMusic stop];
    
    GamePlayScene *gamePlayScene = [GamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithColor:[SKColor colorWithRed:10/255.0 green:190/255.0 blue:23/255.0 alpha:1.0] duration:3.6];
    //    SKTransition *transition = [SKTransition transitionWithCIFilter:@"filter" duration:3.0]; <--look into it
    
    [self.view presentScene:gamePlayScene transition:transition];
}


@end
