//
//  MainViewController.m
//  Game
//
//  Created by Celleus on 2014/08/07.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"

// admob
#import "GADBannerView.h"
#import "AppDelegate.h"

@interface MainViewController (){
    GameViewController *gameViewController;
    GADBannerView *gadBannerView;
}

@end

@implementation MainViewController

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
    
    //**************************************************
    // Admob
    //**************************************************
    gadBannerView = [[GADBannerView alloc]
                     initWithFrame:CGRectMake(0.0,
                                              20.0,
                                              GAD_SIZE_320x50.width,
                                              GAD_SIZE_320x50.height)];
    
    gadBannerView.adUnitID = ADMOB_ID_MAIN;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    gadBannerView.rootViewController = appDelegate.window.rootViewController;
    [self.view addSubview:gadBannerView];
    [gadBannerView loadRequest:[GADRequest request]];
    
    // タイトル
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 50)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    title.text = NSLocalizedString(@"app_name", nil);
    [self.view addSubview:title];
    
    CGFloat paddingY = 280;
    // 4 4s
    if([UIScreen mainScreen].bounds.size.width == 320.0 && [UIScreen mainScreen].bounds.size.height == 480.0) {
        paddingY = 170;
    }
    // 5 5s
    else if([UIScreen mainScreen].bounds.size.width == 320.0 && [UIScreen mainScreen].bounds.size.height == 568.0) {
        paddingY = 280;
    }
    // 6
    else if([UIScreen mainScreen].bounds.size.width == 375.0 && [UIScreen mainScreen].bounds.size.height == 667.0) {
        paddingY = 280;
    }
    // 6+
    else if([UIScreen mainScreen].bounds.size.width == 414.0 && [UIScreen mainScreen].bounds.size.height == 736.0) {
        paddingY = 300;
    }
    
    // スコアアタック
    UIButton *game = [[UIButton alloc] init];
    game.frame = CGRectMake(70, paddingY + 50 + 70, self.view.frame.size.width - 70*2, 50);
    game.backgroundColor = [UIColor colorWithRed:1 green:0.7 blue:0.2 alpha:1];
    game.layer.cornerRadius = 8;
    game.clipsToBounds = YES;
    game.font = [UIFont fontWithName:@"Helvetica" size:18];
    [game setTitle:NSLocalizedString(@"button_game_start", nil) forState:UIControlStateNormal];
    [game setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [game setTitle:NSLocalizedString(@"button_game_start", nil) forState:UIControlStateHighlighted];
    [game addTarget:self action:@selector(game:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:game];
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

- (void)game:(id)sender {
    gameViewController = [[GameViewController alloc] init];
    gameViewController.view.frame = self.view.frame;
    gameViewController.mainViewController = self;
    [self.view addSubview:gameViewController.view];
}

@end
