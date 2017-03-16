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
    
    NSMutableArray *scaffoldArray;
    
    NSTimer *timer;
    NSDate *startDate;
    NSDate *endDate;
    
    float roll;
    float brinkSpeed;
}

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        scaffoldArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.88 blue:0.8 alpha:1];
    
    brinkSpeed = 0;
    roll = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // プレイヤー
    player = [[Player alloc] initWithFrame:CGRectMake(50, 0, PLAYER_SIZE, PLAYER_SIZE)];
    [self.view addSubview:player];
    
    // 初期化してゲームスタート
    [self clearScaffold];
    [self restart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static int count = 0;
- (void)loop:(NSTimer *)timer_ {
    count++;
    
    // 足場の移動
    for (Scaffold *scaffold in scaffoldArray) {
        if (scaffold.flag) {
            if (scaffold.down) {
                scaffold.frame = CGRectMake(scaffold.frame.origin.x + player.speedVX,
                                            scaffold.frame.origin.y + 3,
                                            scaffold.frame.size.width,
                                            scaffold.frame.size.height);
            }
            else {
                scaffold.frame = CGRectMake(scaffold.frame.origin.x + player.speedVX,
                                            scaffold.frame.origin.y,
                                            scaffold.frame.size.width,
                                            scaffold.frame.size.height);
            }
        }
    }
    
    // プレイヤーの移動
    if (player.flag) {
        
        // ジャンプ
        if (touch
            && player.jumpCount > 0) {
            player.speedVY = -(player.speedY * player.jumpPow);
            player.frame = CGRectMake(player.frame.origin.x,
                                      player.frame.origin.y + player.speedVY,
                                      player.frame.size.width,
                                      player.frame.size.height);
            player.jumpCount--;
            touch = nil;
            
            if (player.tag != PLAYER_JUMP) {
                [player setPlayserIamge:PLAYER_JUMP];
            }
        }
        // MEMEジャンプ
        else if (brinkSpeed
            && player.jumpCount > 0) {
            player.speedVY = -brinkSpeed*MEME_JUMP_POW;
            player.frame = CGRectMake(player.frame.origin.x,
                                      player.frame.origin.y + player.speedVY,
                                      player.frame.size.width,
                                      player.frame.size.height);
            player.jumpCount--;
            brinkSpeed = 0;
            
            if (player.tag != PLAYER_JUMP) {
                [player setPlayserIamge:PLAYER_JUMP];
            }
        }
        // そのまま
        else {
            player.frame = CGRectMake(player.frame.origin.x,
                                      player.frame.origin.y + player.speedVY,
                                      player.frame.size.width,
                                      player.frame.size.height);
            player.speedVY = player.speedVY + 0.3;
        }
        
        // 横移動
        if (roll*MEME_X) {
            player.speedVX = roundf(roll*MEME_X);
            if (player.speedVX > MAX_VX) {
                player.speedVX = MAX_VX;
            }
            else if (player.speedVX < -MAX_VX) {
                player.speedVX = -MAX_VX;
            }
            
            if (player.tag == PLAYER_JUMP) {
                [player setPlayserIamge:PLAYER_JUMP];
            }
            else {
                if (player.speedVX <= 0) {
                    if (player.tag != PLAYER_MOVE_L) {
                        [player setPlayserIamge:PLAYER_MOVE_L];
                    }
                }
                else {
                    if (player.tag != PLAYER_MOVE_R) {
                        [player setPlayserIamge:PLAYER_MOVE_R];
                    }
                }
            }
        }
        else {
            if (player.tag != PLAYER_JUMP && player.tag != PLAYER_STOP) {
                [player setPlayserIamge:PLAYER_STOP];
            }
        }
        
        // 足場の判定
        for (Scaffold *scaffold in scaffoldArray) {
            if (scaffold.flag) {
                
                
                // 上の判定
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
                    
                    if (player.tag != PLAYER_STOP && player.tag != PLAYER_MOVE_L && player.tag != PLAYER_MOVE_R && player.tag != PLAYER_BLOCK) {
                        [player setPlayserIamge:PLAYER_STOP];
                    }
                    
                    if (scaffold.type == 2) {
                        scaffold.down = YES;
                    }
                    else if (scaffold.type == 9) {
                        endDate = [NSDate date];
                        [timer invalidate];
                        timer = nil;
                        [self  performSelector:@selector(gameclear) withObject:nil afterDelay:1];
                    }
                }
                
                // 左の判定
                if (scaffold.frame.origin.x <= player.frame.origin.x + player.frame.size.width
                    && scaffold.frame.origin.x - player.speedVX >= player.frame.origin.x + player.frame.size.width
                    && ( (scaffold.frame.origin.y < player.frame.origin.y
                          && scaffold.frame.origin.y + scaffold.frame.size.height > player.frame.origin.y)
                        || (scaffold.frame.origin.y < player.frame.origin.y + player.frame.size.height
                            && scaffold.frame.origin.y + scaffold.frame.size.height > player.frame.origin.y + player.frame.size.height) )
                    ) {
                    
                    player.frame = CGRectMake(scaffold.frame.origin.x - player.frame.size.width,
                                              player.frame.origin.y,
                                              player.frame.size.width,
                                              player.frame.size.height);
                    
                    if (player.tag != PLAYER_BLOCK) {
                        [player setPlayserIamge:PLAYER_BLOCK];
                    }
                    
                    player.speedVX = 0;
                }
                
                // 右の判定
                if (scaffold.frame.origin.x + scaffold.frame.size.width >= player.frame.origin.x
                    && scaffold.frame.origin.x + scaffold.frame.size.width - player.speedVX <= player.frame.origin.x
                    && ( (scaffold.frame.origin.y < player.frame.origin.y
                          && scaffold.frame.origin.y + scaffold.frame.size.height > player.frame.origin.y)
                        || (scaffold.frame.origin.y < player.frame.origin.y + player.frame.size.height
                            && scaffold.frame.origin.y + scaffold.frame.size.height > player.frame.origin.y + player.frame.size.height) )
                    ) {
                    
                    player.frame = CGRectMake(scaffold.frame.origin.x + scaffold.frame.size.width,
                                              player.frame.origin.y,
                                              player.frame.size.width,
                                              player.frame.size.height);
                    
                    if (player.tag != PLAYER_BLOCK) {
                        [player setPlayserIamge:PLAYER_BLOCK];
                    }
                    
                    player.speedVX = 0;
                }
                
            }
        }
    }
    
    // ゲームオーバー
    if (player.frame.origin.y + player.frame.size.height > self.view.frame.size.height
        || player.frame.origin.x + player.frame.size.width < 0) {
        [timer invalidate];
        timer = nil;
        [self  performSelector:@selector(gameover) withObject:nil afterDelay:1];
        
        if (player.tag != PLAYER_DIE) {
            [player setPlayserIamge:PLAYER_DIE];
        }
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

- (void)gameclear {
    gameOverViewController = [[GameOverViewController alloc] init];
    
    NSLog(@"%@",[[MStatus select:@"highScore"] objectForKey:@"value"]);

    NSTimeInterval since = [endDate timeIntervalSinceDate:startDate];
    NSDate *difDate = [NSDate dateWithTimeIntervalSince1970:since];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss.SSS"];
    NSString *dateStr = [dateFormatter stringFromDate:difDate];
    
    if ([[MStatus select:@"highScore"] objectForKey:@"value"]) {
        NSString *highScore = [[MStatus select:@"highScore"] objectForKey:@"value"];
        if ([highScore floatValue] < [dateStr floatValue]) {
            gameOverViewController.score = dateStr;
            gameOverViewController.highScore = [[MStatus select:@"highScore"] objectForKey:@"value"];
        }
        else {
            gameOverViewController.score = dateStr;
            gameOverViewController.highScore = [[MStatus select:@"highScore"] objectForKey:@"value"];
            // ハイスコア更新
            [AppModel beginTransactionDD];
            BOOL isSuccess = YES;
            if (isSuccess) isSuccess = [MStatus update:@"highScore" value:dateStr];
            [AppModel endTransactionDD:isSuccess];
        }
    }
    else {
        gameOverViewController.score = dateStr;
        gameOverViewController.highScore = @"0";
        // ハイスコア更新
        [AppModel beginTransactionDD];
        BOOL isSuccess = YES;
        if (isSuccess) isSuccess = [MStatus insert:@"highScore" value:dateStr];
        [AppModel endTransactionDD:isSuccess];
    }
    
    gameOverViewController.view.frame = self.view.frame;
    gameOverViewController.gameoverLabel.text = @"ゲームクリア";
    gameOverViewController.mainViewController = self.mainViewController;
    gameOverViewController.gameViewController = self;
    [self.view addSubview:gameOverViewController.view];
}

- (void)gameover {
    gameOverViewController = [[GameOverViewController alloc] init];
    
    
    NSLog(@"%@",[[MStatus select:@"highScore"] objectForKey:@"value"]);
    
    if ([[MStatus select:@"highScore"] objectForKey:@"value"]) {
        gameOverViewController.score = @"-";
        gameOverViewController.highScore = [[MStatus select:@"highScore"] objectForKey:@"value"];
    }
    else {
        gameOverViewController.score = @"-";
        gameOverViewController.highScore = @"0";
    }
    
    gameOverViewController.view.frame = self.view.frame;
    gameOverViewController.gameoverLabel.text = @"ゲームオーバー";
    gameOverViewController.mainViewController = self.mainViewController;
    gameOverViewController.gameViewController = self;
    [self.view addSubview:gameOverViewController.view];
}

- (void)clearScaffold {
    for (Scaffold *scaffold in scaffoldArray) {
        [scaffold removeFromSuperview];
    }
    [scaffoldArray removeAllObjects];
}
- (void)restart {
    startDate = [NSDate date];
    
    // player
    player.frame = CGRectMake(50, self.view.frame.size.height/2, PLAYER_SIZE, PLAYER_SIZE);
    player.speedVY = 0;
    player.speedVX = 0;
    [player setPlayserIamge:PLAYER_JUMP];
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSError *error;
    path = [[NSBundle mainBundle] pathForResource:@"stage" ofType:@"csv"];
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSArray *lines = [csv componentsSeparatedByString:@"\n"];
    
    CGFloat size = self.view.frame.size.height / [lines count];
    int x = 0;
    int y = 0;
    for (NSString *line in lines) {
        NSArray *blocks = [line componentsSeparatedByString:@","];
        for (NSString *block in blocks) {
            
            if ([block intValue] == 1) {
                
                Scaffold *scaffold = [[Scaffold alloc] initWithFrame:CGRectMake(size * x,
                                                                                size * y,
                                                                                size,
                                                                                size)];
                scaffold.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
                scaffold.type = [block intValue];
                [self.view addSubview:scaffold];
                [scaffoldArray addObject:scaffold];
                
            }
            else if ([block intValue] == 2)  {
                
                Scaffold *scaffold = [[Scaffold alloc] initWithFrame:CGRectMake(size * x,
                                                                                size * y,
                                                                                size,
                                                                                size)];
                scaffold.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
                scaffold.type = [block intValue];
                [self.view addSubview:scaffold];
                [scaffoldArray addObject:scaffold];
                
            }
            else if ([block intValue] == 9)  {
                
                Scaffold *scaffold = [[Scaffold alloc] initWithFrame:CGRectMake(size * x,
                                                                                size * y,
                                                                                size,
                                                                                size)];
                scaffold.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
                scaffold.type = [block intValue];
                [self.view addSubview:scaffold];
                [scaffoldArray addObject:scaffold];
            }
            
            x++;
        }
        x = 0;
        y++;
    }
    
    
    
    // タイマー
    CGFloat l = 1.0f / FPS;
    timer = [NSTimer
             timerWithTimeInterval:l
             target:self
             selector:@selector(loop:)
             userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)memeRealTimeModeDataReceived:(MEMERealTimeData *)data
{
    if (timer) {
        roll = data.roll;
        brinkSpeed = data.blinkSpeed;
    }
}

@end
