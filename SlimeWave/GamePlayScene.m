//
//  GamePlayScene.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/26/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "GamePlayScene.h"
#import "GameOverScene.h"
#import "MadScientistNode.h"
#import "SewerRiverNode.h"
#import "PipeNode.h"
#import "WaterfallNode.h"
#import "SplashNode.h"
#import "LaserBlastNode.h"
#import "GroundNode.h"
#import "HUDNode.h"
#import "WallNode.h"
#import "Utility.h"
#import <AVFoundation/AVFoundation.h>
#import "SlimeNode.h"

@interface GamePlayScene ()

@property (nonatomic)SKSpriteNode  *node1,*node2;
@property (nonatomic)SKLabelNode *timeLabel;
@property (nonatomic)PipeNode *pipe1, *pipe2;
@property (nonatomic)NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic)NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic)NSTimeInterval totalGameTime;
@property (nonatomic)NSTimeInterval addEnemyTimeInterval;
@property (nonatomic)NSInteger minSpeed;
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property (nonatomic) AVAudioPlayer *gameoverMusic;
@property (nonatomic)BOOL gameOver;
@property (nonatomic)BOOL gameOverIsDisplayed;
@property (nonatomic)BOOL restart;


@end

@implementation GamePlayScene

-(void)didMoveToView:(SKView *)view {
    
    self.timeSinceEnemyAdded = 0;
    self.lastUpdateTimeInterval = 0;
    self.totalGameTime = 0;
    self.addEnemyTimeInterval = 1.0;
    self.minSpeed = SlimeMinimumSpeed;
    self.gameOver = NO;
    self.gameOverIsDisplayed = NO;
    self.restart = NO;
    
    /* Setup your scene here */
    
//    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"SewerBackground"];
//    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//   [self addChild:background];
//    background.size = self.frame.size;
//    background.zPosition = 0;
    
    
    SKSpriteNode *background =[SKSpriteNode spriteNodeWithImageNamed:@"SewerBackground"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    background.zPosition = 0;
    background.size = self.frame.size;
    SKAction *moveBackGroundRight = [SKAction moveByX:7 y:1 duration:2.5];
    SKAction *moveBackGroundLeft = [SKAction moveByX:-7 y:-1 duration:1.5];
    SKAction *moveDown =[SKAction moveByX:0 y:8 duration:1];
    SKAction *moveUp = [SKAction moveByX:0 y:-8 duration:0.7];
    SKAction *moveAround = [SKAction group:@[moveBackGroundRight,moveBackGroundLeft,moveUp,moveDown]];
    SKAction *moveForever = [SKAction repeatActionForever:moveAround];
    
    [background runAction:moveForever];
    
    [self addChild:background];
    
    
    SKLabelNode *getReadyLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    getReadyLabel.text = @"Slime Wave!";
    getReadyLabel.fontSize = 25;
    getReadyLabel.fontColor = [SKColor whiteColor];
    getReadyLabel.position = CGPointMake(CGRectGetMidX(self.frame), 350);
    getReadyLabel.zPosition = 3;
    SKAction *labelTransition = [SKAction fadeOutWithDuration:0.4];
    SKAction *labelTransition2= [SKAction fadeInWithDuration:0.4];
    NSArray *sequence =  @[labelTransition,labelTransition2];
    [self addChild:getReadyLabel];
    [getReadyLabel runAction:[SKAction repeatAction:[SKAction sequence:sequence] count:3]completion:^{
    [getReadyLabel removeFromParent];
    }];
    
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
   
    MadScientistNode *madScientist = [MadScientistNode madScientistAtPosition:CGPointMake(CGRectGetMidX(self.frame),80 )];
    [self addChild:madScientist];
    
    GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width,1)];
    [self addChild:ground];

    SewerRiverNode *sewerRiver = [SewerRiverNode sewerRiverAtPosition:CGPointMake(CGRectGetMidX(self.frame), 200 )];
    [self addChild:sewerRiver];
    
    self.pipe1 = [PipeNode pipeAtPosition:CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame))];
    self.pipe1.anchorPoint = CGPointMake(0, 1);
    [self addChild:self.pipe1];
    
    self.pipe2 = [PipeNode pipeAtPosition:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    self.pipe2.anchorPoint = CGPointMake(1, 1);
    [self addChild:self.pipe2];
    
    WaterfallNode *waterfall = [WaterfallNode waterfallAtPosition:CGPointMake(CGRectGetMidX(self.frame)-10,CGRectGetMidY(self.frame)+70)];
    [self addChild:waterfall];
    
    SplashNode *splash = [SplashNode splashAtPosition:CGPointMake(waterfall.position.x+10, waterfall.position.y -130)];
    [self addChild:splash];
    
    HUDNode *hud = [HUDNode hudAtPosition:CGPointMake(0, self.frame.size.height - 20) inFrame:self.frame];
    [self addChild:hud];
    
    [self setupSounds];
    
    self.node1 = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(5,5)];
    self.node2 = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(5, 5)];
    self.node1.position = CGPointMake(madScientist.position.x - 50,madScientist.position.y + 80);
    self.node2.position = CGPointMake(madScientist.position.x + 30, madScientist.position.y + 80);
        
    [self addChild:self.node1];
    [self addChild:self.node2];
}

-(void)setupSounds
{
    NSURL *gamePlayUrl = [[NSBundle mainBundle] URLForResource:@"gamePlayMusic" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:gamePlayUrl error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
    [self.backgroundMusic play];
    
//    NSURL *gameOverUrl = [[NSBundle mainBundle] URLForResource:@"gameOverMusic" withExtension:@"mp3"];
//    self.gameoverMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:gameOverUrl error:nil];
//    self.gameoverMusic.numberOfLoops = -1;
//    [self.gameoverMusic prepareToPlay];
    
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
}

-(void)timerMethod
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.gameOver)
    {
        for (UITouch *touch in touches)
        {
            CGPoint position = [touch locationInNode:self];
            [self shootLaserTowardsPosition:position];
            
        }
    }

    else if (self.restart)
    {
        for (SKNode *node in [self children])
        {
            [node removeFromParent];
        }
        
        GamePlayScene *gamePlayScene = [GamePlayScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:gamePlayScene];
    }
}

-(void)shootLaserTowardsPosition: (CGPoint)position
{
    MadScientistNode *madScientist = (MadScientistNode *)[self childNodeWithName:@"MadScientist"];
    [madScientist performTap];
    
    LaserBlastNode *laserBlast1 = [LaserBlastNode laserBlastAtPosition:CGPointMake
                                  (self.node1.position.x,
                                   self.node2.position.y)];
    [self addChild:laserBlast1];
    [laserBlast1 moveTowardsPosition:position];
    
    LaserBlastNode *laserBlast2 = [LaserBlastNode laserBlastAtPosition:CGPointMake
                                   (self.node2.position.x,
                                    self.node2.position.y)];
    [self addChild:laserBlast2];
    [laserBlast2 moveTowardsPosition:position];
    
    [self runAction:self.laserSFX];
}

-(void)addSlime
{
    float dy = [Utility randomWithMin:SlimeMinimumSpeed    max:SlimeMaximumSpeed];
    float dx =  [Utility randomWithMin:-25  max:50];
    float dx2 =  [Utility randomWithMin:-50  max:25];

    
    NSInteger randomSlime = [Utility randomWithMin:0 max:4];
    SlimeNode *slime = [SlimeNode slimeOfType:randomSlime];
    slime.physicsBody.velocity = CGVectorMake(dx, dy);
    slime.position = CGPointMake(self.pipe1.position.x +60, self.pipe1.position.y);
    [self addChild:slime];
    
    NSInteger randomSlime2 = [Utility randomWithMin:0 max:4];
    SlimeNode *slime2 = [SlimeNode slimeOfType:randomSlime2];
    slime2.physicsBody.velocity = CGVectorMake(dx2, dy);
    slime2.position = CGPointMake(self.pipe2.position.x-50, self.pipe2.position.y);
    [self addChild:slime2];
}

-(void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTimeInterval) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver)
    {
        [self addSlime];
        self.timeSinceEnemyAdded = 0;
        
    }
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime  > 65)
    {        //480/60 = 8 minutes
        self.addEnemyTimeInterval = 0.30;
        self.minSpeed =  -210;
    }
    else if (self.totalGameTime  > 55)
    {        //240/60 = 4 minutes
        self.addEnemyTimeInterval = 0.40;
        self.minSpeed =  -195;
    }
    else if (self.totalGameTime > 40)
    {       //120/60 = 2 minutes;
        self.addEnemyTimeInterval = 0.50;
        self.minSpeed = -180;
    }
    else if (self.totalGameTime > 25)
    {       //30seconds
        self.addEnemyTimeInterval = 0.60;
        self.minSpeed = -165;
    }
    else if (self.totalGameTime  > 15)
    {        //240/60 = 4 minutes
        self.addEnemyTimeInterval = 0.70;
        self.minSpeed =  -150;
    }
    
    if (self.gameOver && !self.gameOverIsDisplayed)
    {
        // [self.performGameOver];----OLD Method without new Scene just Node.
        
        self.restart = YES;
        self.gameOverIsDisplayed = YES;
        
        [self.backgroundMusic stop];
//        [self.gameoverMusic play];
        GameOverScene *endScene = [GameOverScene sceneWithSize:self.size];
        [self.view presentScene:endScene transition: [SKTransition fadeWithColor: [SKColor colorWithRed:10/255.0 green:190/255.0 blue:23/255.0 alpha:1.0] duration:3.0]];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody,*secondBody;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else{
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
        secondBody.categoryBitMask == CollisionCategoryProjectile)
    {
        //NSLog(@"BAM!");
        SlimeNode *slime  = (SlimeNode *)firstBody.node;
        LaserBlastNode *laserBlast  = (LaserBlastNode *)secondBody.node;
        
        [self addPoints:PointsPerHit];
        
        [self runAction:self.explodeSFX];
        
        [slime removeFromParent];
        [laserBlast removeFromParent];
    }
    else if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
             secondBody.categoryBitMask == CollisionCategoryGround)
    {
        //NSLog(@"Enemy Landed!");
        [self runAction:self.damageSFX];
        
        SlimeNode *slime = (SlimeNode *)firstBody.node;
        [slime removeFromParent];
        [self loseLife];
    }
    [self createDebrisAtPosition:contact.contactPoint];
}

-(void) addPoints: (NSInteger)points
{
    HUDNode *hud =  (HUDNode *)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

-(void)loseLife
{
    HUDNode *hud =  (HUDNode *)[self childNodeWithName:@"HUD"];
    self.gameOver = [hud loseLife];
}

-(void)createDebrisAtPosition: (CGPoint)position
{
    NSInteger numberOfPieces =  [Utility randomWithMin:6 max:10];
    
    for (int i = 0; i < numberOfPieces; i++)
    {
        NSInteger randomPiece = [Utility randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"Goop_%li",(long)randomPiece];
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        debris.zPosition = 3;
        
        float scale = [Utility randomWithMin:20 max:50] / 100.0f;
        debris.xScale = scale;
        debris.yScale = scale;
        
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategoryGround | CollisionCategoryDebris;
        debris.name = @"Goop";
        debris.physicsBody.velocity = CGVectorMake([Utility randomWithMin:-150 max:150],
                                                   [Utility randomWithMin:150 max:350]);
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
    }
    
    NSString *explosionPath = [[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    explosion.zPosition = 3;
    explosion.position = position;
    [self addChild:explosion];
    [explosion runAction:[SKAction waitForDuration:0.4] completion:^{
        [explosion removeFromParent];
    }];
}

//-(void)performGameOver
//{
//    GameOverNode *gameOver = [GameOverNode gameOverAtPosition:CGPointMake
//                          (CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
//    [self addChild:gameOver];
//    self.restart = YES;
//    self.gameOverIsDisplayed = YES;
//    
////    [gameOver performAnimation];
//    
//    [self.backgroundMusic stop];
//   // [self.gameoverMusic play];
//}

@end
