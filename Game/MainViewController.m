//
//  MainViewController.m
//  Game
//
//  Created by Celleus on 2014/08/07.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "PairingViewController.h"

// admob
#import "AppDelegate.h"

@interface MainViewController () <MEMELibDelegate> {
    GameViewController *gameViewController;
    PairingViewController *pairingViewController;
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
    
    [MEMELib setAppClientId:@"573253799739733" clientSecret:@"n7ic2mhr01j4wvomur27g98lre233vlf"];
    [MEMELib sharedInstance].delegate = self;
    [[MEMELib sharedInstance] addObserver:self forKeyPath:@"centralManagerEnabled" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.88 blue:0.8 alpha:1];
    
    // タイトル
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 50)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    title.text = @"スーパーミーム";
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
    [game setTitle:@"ゲームスタート" forState:UIControlStateNormal];
    [game setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [game setTitle:@"ゲームスタート" forState:UIControlStateHighlighted];
    [game addTarget:self action:@selector(game:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:game];
    
    // ペアリング
    UIButton *pearing = [[UIButton alloc] init];
    pearing.frame = CGRectMake(70, paddingY + 50 + 70*2, self.view.frame.size.width - 70*2, 50);
    pearing.backgroundColor = [UIColor colorWithRed:1 green:0.2 blue:0.2 alpha:1];
    pearing.layer.cornerRadius = 8;
    pearing.clipsToBounds = YES;
    pearing.font = [UIFont fontWithName:@"Helvetica" size:18];
    [pearing setTitle:@"ペアリング" forState:UIControlStateNormal];
    [pearing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pearing setTitle:@"ペアリング" forState:UIControlStateHighlighted];
    [pearing addTarget:self action:@selector(pearing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:pearing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)game:(id)sender {
    gameViewController = [[GameViewController alloc] init];
    gameViewController.mainViewController = self;
    [self presentViewController:gameViewController animated:NO completion:^(void){}];
}

- (void)pearing:(id)sender {
    pairingViewController = [[PairingViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:pairingViewController];
    [self presentViewController:nvc animated:NO completion:^(void){}];
}

//**************************************************
// jins meme delegate
//**************************************************

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath:%@",keyPath);
}

- (void) memeAppAuthorized:(MEMEStatus)status
{
    NSLog(@"memeAppAuthorized");
}

- (void)memePeripheralFound:(CBPeripheral *)peripheral withDeviceAddress:(NSString *)address
{
    NSLog(@"memePeripheralFound:%@",[peripheral.identifier UUIDString]);
    
    if ([pairingViewController.peripherals indexOfObject:peripheral] == NSNotFound) {
        
        [pairingViewController.peripherals addObject:peripheral];
        
        [pairingViewController.peripheralListTableView reloadData];
    }
}

- (void)memePeripheralConnected:(CBPeripheral *)peripheral
{
    NSLog(@"memePeripheralConnected:%@",[peripheral.identifier UUIDString]);
    
    [pairingViewController dismissViewControllerAnimated:NO completion:nil];
    
    [[MEMELib sharedInstance] startDataReport];
}

- (void)memeRealTimeModeDataReceived:(MEMERealTimeData *)data
{
    //NSLog(@"data:%@",data);
    if (gameViewController) {
        [gameViewController memeRealTimeModeDataReceived:data];
    }
}

@end
