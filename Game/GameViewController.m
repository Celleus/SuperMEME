//
//  GameViewController.m
//  Game
//
//  Created by Celleus on 2014/08/07.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "GameViewController.h"
#import "GameOverViewController.h"
#import "MStatus.h"

#import "Player.h"
#import "Scaffold.h"

@interface GameViewController () {
    GameOverViewController *gameOverViewController;
    
    UITouch *touch;
    
    Player *player;
    NSMutableArray *playerArray;
    
    NSMutableArray *scaffoldArray;
    
    UILabel *score;
}

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        playerArray = [[NSMutableArray alloc] init];
        scaffoldArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.88 blue:0.8 alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ポイント
    score = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 50)];
    score.backgroundColor = [UIColor clearColor];
    score.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    score.textAlignment = NSTextAlignmentCenter;
    score.font = [UIFont fontWithName:@"Helvetica" size:50];
    score.text = @"0";
    [self.view addSubview:score];
    
    // player
    player = [[Player alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
    [self.view addSubview:player];
    
    Scaffold *scaffold = [[Scaffold alloc] initWithFrame:CGRectMake(150,
                                                                    self.view.frame.size.height / 2 - 100 + (arc4random()%200),
                                                                    (arc4random()%50) + 100,
                                                                    5)];
    scaffold.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:scaffold];
    [scaffoldArray addObject:scaffold];
    
    // タイマー
    CGFloat l = 1.0f / 60.0f;
    NSTimer *timer = [NSTimer
                      timerWithTimeInterval:l
                      target:self
                      selector:@selector(loop:)
                      userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static int count = 0;
- (void)loop:(NSTimer *)timer {
    count++;
    
    // 足場の移動
    for (Scaffold *scaffold in scaffoldArray) {
        if (scaffold.flag) {
            if (scaffold.down) {
                scaffold.frame = CGRectMake(scaffold.frame.origin.x - player.speedX,
                                            scaffold.frame.origin.y + 3,
                                            scaffold.frame.size.width,
                                            scaffold.frame.size.height);
            }
            else {
                scaffold.frame = CGRectMake(scaffold.frame.origin.x - player.speedX,
                                            scaffold.frame.origin.y,
                                            scaffold.frame.size.width,
                                            scaffold.frame.size.height);
            }
        }
    }
    
    Scaffold *s = [scaffoldArray lastObject];
    if (s.frame.origin.x < self.view.frame.size.width) {
        CGFloat y = 0;
        while (!y) {
             y = s.frame.origin.y - 75 + (arc4random()%250);
            if (y < 75 || y > self.view.frame.size.height - 100) {
                y = 0;
            }
        }
        Scaffold *scaffold = [[Scaffold alloc] initWithFrame:CGRectMake(s.frame.origin.x + s.frame.size.width + (arc4random()%75) + 50,
                                                                        y,
                                                                        (arc4random()%100) + 50,
                                                                        5)];
        scaffold.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self.view addSubview:scaffold];
        [scaffoldArray addObject:scaffold];
    }
    
    
    // プレイヤーの移動
    if (player.flag) {
        
        // ジャンプかそのままか
        if (touch
            && player.jumpCount > 0) {
            player.speedVY = -(player.speedY * player.jumpPow);
            player.frame = CGRectMake(player.frame.origin.x,
                                      player.frame.origin.y + player.speedVY,
                                      player.frame.size.width,
                                      player.frame.size.height);
            player.jumpCount--;
            touch = nil;
        }
        else {
            player.frame = CGRectMake(player.frame.origin.x,
                                      player.frame.origin.y + player.speedVY,
                                      player.frame.size.width,
                                      player.frame.size.height);
            player.speedVY = player.speedVY + 0.3;
        }
        
        
        // 足場の判定
        for (Scaffold *scaffold in scaffoldArray) {
            if (scaffold.flag) {
                if (scaffold.frame.origin.y <= player.frame.origin.y + player.frame.size.height
                    && scaffold.frame.origin.y + player.speedVY >= player.frame.origin.y + player.frame.size.height
                    && ( (scaffold.frame.origin.x < player.frame.origin.x
                          && scaffold.frame.origin.x + scaffold.frame.size.width > player.frame.origin.x)
                        || (scaffold.frame.origin.x < player.frame.origin.x + player.frame.size.width
                            && scaffold.frame.origin.x + scaffold.frame.size.width > player.frame.origin.x + player.frame.size.width) )
                    ) {
                    
                    player.frame = CGRectMake(player.frame.origin.x,
                                              scaffold.frame.origin.y - player.frame.size.height,
                                              player.frame.size.width,
                                              player.frame.size.height);
                    
                    player.speedVY = player.speedY;
                    player.jumpCount = player.jumpCountMax;
                    
                    scaffold.down = YES;
                    
                    if (!scaffold.score) {
                        scaffold.score = YES;
                        score.text = [NSString stringWithFormat:@"%d",[score.text intValue] + 1 ];
                    }
                }
                else {
                    
                }
            }
        }
    }
    
    // ゲームオーバー
    if (player.frame.origin.y + player.frame.size.height > self.view.frame.size.height
        || player.frame.origin.x + player.frame.size.width < 0) {
        [timer invalidate];
        [self  performSelector:@selector(gameover) withObject:nil afterDelay:1];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touch = [touches anyObject];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (player.speedVY < 0) {
        player.speedVY = player.speedVY / 2;
    }
    touch = nil;
}

- (void)gameover {
    gameOverViewController = [[GameOverViewController alloc] init];
    
    NSLog(@"%@",[[MStatus select:@"highScore"] objectForKey:@"value"]);
    
    if ([[MStatus select:@"highScore"] objectForKey:@"value"]) {
        NSString *highScore = [[MStatus select:@"highScore"] objectForKey:@"value"];
        if ([highScore intValue] > [score.text intValue]) {
            gameOverViewController.score = score.text;
            gameOverViewController.highScore = [[MStatus select:@"highScore"] objectForKey:@"value"];
        }
        else {
            gameOverViewController.score = score.text;
            gameOverViewController.highScore = [[MStatus select:@"highScore"] objectForKey:@"value"];
            // ハイスコア更新
            [AppModel beginTransactionDD];
            BOOL isSuccess = YES;
            if (isSuccess) isSuccess = [MStatus update:@"highScore" value:score.text];
            [AppModel endTransactionDD:isSuccess];
        }
    }
    else {
        gameOverViewController.score = score.text;
        gameOverViewController.highScore = @"0";
        // ハイスコア更新
        [AppModel beginTransactionDD];
        BOOL isSuccess = YES;
        if (isSuccess) isSuccess = [MStatus insert:@"highScore" value:score.text];
        [AppModel endTransactionDD:isSuccess];
    }
    
    gameOverViewController.view.frame = self.view.frame;
    gameOverViewController.mainViewController = self.mainViewController;
    [self.view addSubview:gameOverViewController.view];
}

@end
