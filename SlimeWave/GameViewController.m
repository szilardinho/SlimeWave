//
//  GameViewController.m
//  SlimeWave
//
//  Created by Szi Gabor on 10/26/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "GameViewController.h"
#import "TitleScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)fadeView:(UIView*)view toAlpha:(CGFloat)alpha
{
    view.layer.shouldRasterize = YES;
    
    [UIView animateWithDuration:4.0
                     animations:^{
                         view.alpha = alpha;
                     }
                     completion:^(BOOL finished){
                         view.layer.shouldRasterize = NO;
                         [view removeFromSuperview];
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    SKScene * scene = [TitleScene sceneWithSize:skView.frame.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    
    // Present the scene.
   // SKTransition *transition = [SKTransition fadeWithColor:[SKColor blackColor] duration:3.6];
    [skView presentScene:scene];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self fadeView:self.viewLaunch toAlpha:0.0f];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

/*- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
