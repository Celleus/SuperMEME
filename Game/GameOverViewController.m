//
//  GameOverViewController.m
//  Game
//
//  Created by Celleus on 2014/08/07.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "GameOverViewController.h"
#import "GameViewController.h"
#import "MainViewController.h"

#import "AppDelegate.h"

@interface GameOverViewController () {
    GameViewController *gameViewController;
}

@end

@implementation GameOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.88 blue:0.8 alpha:1];
    
    CGFloat paddingY = 260;
    CGFloat paddingY_ = 0;
    // 4 4s
    if([UIScreen mainScreen].bounds.size.width == 320.0 && [UIScreen mainScreen].bounds.size.height == 480.0) {
        paddingY = 170;
        paddingY_ = 35;
    }
    // 5 5s
    else if([UIScreen mainScreen].bounds.size.width == 320.0 && [UIScreen mainScreen].bounds.size.height == 568.0) {
        paddingY = 260;
        paddingY_ = 0;
    }
    // 6
    else if([UIScreen mainScreen].bounds.size.width == 375.0 && [UIScreen mainScreen].bounds.size.height == 667.0) {
        paddingY = 260;
        paddingY_ = 0;
    }
    // 6+
    else if([UIScreen mainScreen].bounds.size.width == 414.0 && [UIScreen mainScreen].bounds.size.height == 736.0) {
        paddingY = 260;
        paddingY_ = 0;
    }
    
    // スコア
    self.gameoverLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY-200+paddingY_, self.view.frame.size.width-20*2, 80)];
    self.gameoverLabel.backgroundColor = [UIColor clearColor];
    self.gameoverLabel.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    self.gameoverLabel.textAlignment = NSTextAlignmentCenter;
    self.gameoverLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    [self.view addSubview:self.gameoverLabel];
    
    // スコア
    UILabel *scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 130+paddingY_, self.view.frame.size.width-20*2, 30)];
    scoreLable.backgroundColor = [UIColor clearColor];
    scoreLable.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    scoreLable.textAlignment = NSTextAlignmentCenter;
    scoreLable.font = [UIFont fontWithName:@"Helvetica" size:20];
    scoreLable.text = @"スコア";
    [self.view addSubview:scoreLable];
    
    UILabel *scoreLable_ = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 100+paddingY_, self.view.frame.size.width-20*2, 30)];
    scoreLable_.backgroundColor = [UIColor clearColor];
    scoreLable_.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    scoreLable_.textAlignment = NSTextAlignmentCenter;
    scoreLable_.font = [UIFont fontWithName:@"Helvetica" size:20];
    scoreLable_.text = self.score;
    [self.view addSubview:scoreLable_];
    
    // ハイスコア
    UILabel *highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 60+paddingY_, self.view.frame.size.width-20*2, 30)];
    highScoreLabel.backgroundColor = [UIColor clearColor];
    highScoreLabel.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    highScoreLabel.textAlignment = NSTextAlignmentCenter;
    highScoreLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    highScoreLabel.text = @"ハイスコア";
    [self.view addSubview:highScoreLabel];
    
    UILabel *highScoreLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 30+paddingY_, self.view.frame.size.width-20*2, 30)];
    highScoreLabel_.backgroundColor = [UIColor clearColor];
    highScoreLabel_.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    highScoreLabel_.textAlignment = NSTextAlignmentCenter;
    highScoreLabel_.font = [UIFont fontWithName:@"Helvetica" size:20];
    highScoreLabel_.text = self.highScore;
    [self.view addSubview:highScoreLabel_];
    
    // もう一度
    UIButton *replay = [[UIButton alloc] init];
    replay.frame = CGRectMake(70, paddingY + 50 + 70, self.view.frame.size.width - 70*2, 50);
    replay.backgroundColor = [UIColor colorWithRed:1 green:0.7 blue:0.2 alpha:1];
    replay.layer.cornerRadius = 8;
    replay.clipsToBounds = YES;
    replay.font = [UIFont fontWithName:@"Helvetica" size:18];
    [replay setTitle:@"もう一度" forState:UIControlStateNormal];
    [replay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [replay setTitle:@"もう一度" forState:UIControlStateHighlighted];
    [replay addTarget:self action:@selector(replay:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:replay];
    
    // もどる
    UIButton *title = [[UIButton alloc] init];
    title.frame = CGRectMake(70, paddingY + 50 + 70*2, self.view.frame.size.width - 70*2, 50);
    title.backgroundColor = [UIColor colorWithRed:1 green:0.2 blue:0.2 alpha:1];
    title.layer.cornerRadius = 8;
    title.clipsToBounds = YES;
    title.font = [UIFont fontWithName:@"Helvetica" size:18];
    [title setTitle:@"タイトル" forState:UIControlStateNormal];
    [title setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [title setTitle:@"タイトル" forState:UIControlStateHighlighted];
    [title addTarget:self action:@selector(title:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:title];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)replay:(id)sender {
    [self.gameViewController clearScaffold];
    [self.view removeFromSuperview];
    [self.gameViewController restart];
}

- (void)title:(id)sender {
    [self.gameViewController clearScaffold];
    [self.mainViewController dismissViewControllerAnimated:YES completion:^(void){}];
}
@end
