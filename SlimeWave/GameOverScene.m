//
//  GameOverScene.m
//  SlimeWave
//
//  Created by Szi Gabor on 11/10/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "GameOverScene.h"
#import "GamePlayScene.h"
#import "WallNode.h"
#import "SlimeNode.h"
#import "Utility.h"
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>


@interface GameOverScene ()

@property (nonatomic)AVAudioPlayer *gameoverMusic;
@property (nonatomic)SKSpriteNode *tweetButton;
@property (nonatomic) BOOL wasPressed;
@end

static const int32_t tweetCategory =         0x1;

@implementation GameOverScene


-(void)didMoveToView:(SKView *)view
{
    self.userInteractionEnabled = YES;
    
    self.tweetButton = [SKSpriteNode spriteNodeWithImageNamed:@"Facebookwall"];
    self.tweetButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-250);
    self.tweetButton.name = @"tweet";
    self.tweetButton.physicsBody.categoryBitMask = tweetCategory;
    [self addChild:self.tweetButton];
    
    
    SKLabelNode *tweetPostLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    tweetPostLabel.fontName =@"Futura-CondensedExtraBold";
    tweetPostLabel.text =  @"Share SlimeWave with Your Friends";
    tweetPostLabel.fontSize = 15;
    tweetPostLabel.fontColor = [SKColor whiteColor];
    tweetPostLabel.position = CGPointMake(self.tweetButton.position.x, self.tweetButton.position.y + 50);;
    tweetPostLabel.zPosition = 2;
    [self addChild:tweetPostLabel];
    
    
    self.backgroundColor = [SKColor colorWithRed:10/255.0 green:190/255.0 blue:23/255.0 alpha:1.0];
    NSURL *gameOverUrl = [[NSBundle mainBundle]URLForResource:@"gameOverMusic" withExtension:@"mp3"];
    self.gameoverMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:gameOverUrl error:nil];
    self.gameoverMusic.numberOfLoops = -1;
    [self.gameoverMusic prepareToPlay];
    [self.gameoverMusic play];
    
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 54;
    gameOverLabel.fontColor = [SKColor whiteColor];
    gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    gameOverLabel.zPosition = 2;
    [self addChild:gameOverLabel];
    
    NSInteger randomSlime = [Utility randomWithMin:0 max:4];
    SlimeNode *slime = [SlimeNode slimeOfType:randomSlime];
    slime.position = CGPointMake(gameOverLabel.position.x, gameOverLabel.position.y + 60);
    slime.zPosition = 2;
    [self addChild:slime];
    
    SKAction *transitionGameOverLabel = [SKAction fadeOutWithDuration:3.0];
    SKAction *transitionGameOverLabel2 = [SKAction fadeInWithDuration:3.0];
    
    NSArray *sequence =  @[transitionGameOverLabel,transitionGameOverLabel2];
    [gameOverLabel runAction:[SKAction repeatActionForever:[SKAction sequence:sequence]]];
    
    SKLabelNode *tryAgainLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    tryAgainLabel.text =  @"Tap to play again";
    tryAgainLabel.fontSize = 30;
    tryAgainLabel.fontColor = [SKColor whiteColor];
    tryAgainLabel.position = CGPointMake(gameOverLabel.position.x, gameOverLabel.position.y - 300);
    tryAgainLabel.zPosition = 1;
    [self addChild:tryAgainLabel];
    
    SKAction *transitionTryAgainLabel = [SKAction moveBy:CGVectorMake(0, 600) duration:6.0];
    SKAction *transitionTryAgainLabel2 = [SKAction moveBy:CGVectorMake(0, -600) duration:6.0];
    NSArray *sequence2 =  @[transitionTryAgainLabel,transitionTryAgainLabel2];
    [tryAgainLabel runAction:[SKAction repeatActionForever:[SKAction sequence:sequence2]]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    GamePlayScene *gameScene = [GamePlayScene sceneWithSize:self.size];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    
    
        if([[self nodeAtPoint:location].name isEqualToString:@"tweet"]){
            //present scene code here
    
        //  Create an instance of the Tweet Sheet
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:
                                               SLServiceTypeFacebook];
        
        // Sets the completion handler.  Note that we don't know which thread the
        // block will be called on, so we need to ensure that any required UI
        // updates occur on the main queue
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    [self.view presentScene:gameScene transition: [SKTransition doorsOpenHorizontalWithDuration:2.0]];
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    [self.view presentScene:gameScene transition: [SKTransition doorsOpenHorizontalWithDuration:2.0]];
                    break;
            }
            
        };
        
        //  Set the initial body of the Tweet
        [tweetSheet setInitialText:@"Share SlimeWave with your friends!"];
        
        //  Adds an image to the Tweet.  Image named image.png
        if (![tweetSheet addImage:[UIImage imageNamed:@"TitleSceneforFB"]]) {
            NSLog(@"Error: Unable to add image");
        }
        
        //  Add an URL to the Tweet.  You can add multiple URLs.
        if (![tweetSheet addURL:[NSURL URLWithString:@"*insert link to AppStore here*"]]){
            NSLog(@"Error: Unable to URL");
        }
        UIViewController *controller = self.view.window.rootViewController;
        [controller presentViewController:tweetSheet animated: YES completion:nil];
    }
    
    else
    
        [self.view presentScene:gameScene transition:[SKTransition fadeWithColor: [SKColor colorWithRed:10/255.0 green:190/255.0 blue:23/255.0 alpha:1.0] duration:4.0]];;
        [self.gameoverMusic stop];
    
        }
    
}

@end