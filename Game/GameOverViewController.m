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
#import "CustomAlertView.h"

// admob
#import "GADBannerView.h"
#import "AppDelegate.h"

@interface GameOverViewController () {
    GameViewController *gameViewController;
    GADBannerView *gadBannerView;
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
    
    //**************************************************
    // Admob
    //**************************************************
    gadBannerView = [[GADBannerView alloc]
                     initWithFrame:CGRectMake(0.0,
                                              20.0,
                                              GAD_SIZE_320x50.width,
                                              GAD_SIZE_320x50.height)];
    
    gadBannerView.adUnitID = ADMOB_ID_GAMEOVER;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    gadBannerView.rootViewController = appDelegate.window.rootViewController;
    [self.view addSubview:gadBannerView];
    [gadBannerView loadRequest:[GADRequest request]];
    
    // スコア
    UILabel *gameoverLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY-200+paddingY_, 280, 80)];
    gameoverLabel.backgroundColor = [UIColor clearColor];
    gameoverLabel.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    gameoverLabel.textAlignment = NSTextAlignmentCenter;
    gameoverLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    gameoverLabel.text = NSLocalizedString(@"label_game_over", nil);
    [self.view addSubview:gameoverLabel];
    
    // スコア
    UILabel *scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 130+paddingY_, 280, 30)];
    scoreLable.backgroundColor = [UIColor clearColor];
    scoreLable.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    scoreLable.textAlignment = NSTextAlignmentCenter;
    scoreLable.font = [UIFont fontWithName:@"Helvetica" size:20];
    scoreLable.text = NSLocalizedString(@"label_socre", nil);
    [self.view addSubview:scoreLable];
    
    UILabel *scoreLable_ = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 100+paddingY_, 280, 30)];
    scoreLable_.backgroundColor = [UIColor clearColor];
    scoreLable_.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    scoreLable_.textAlignment = NSTextAlignmentCenter;
    scoreLable_.font = [UIFont fontWithName:@"Helvetica" size:20];
    scoreLable_.text = self.score;
    [self.view addSubview:scoreLable_];
    
    // ハイスコア
    UILabel *highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 60+paddingY_, 280, 30)];
    highScoreLabel.backgroundColor = [UIColor clearColor];
    highScoreLabel.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    highScoreLabel.textAlignment = NSTextAlignmentCenter;
    highScoreLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    highScoreLabel.text = NSLocalizedString(@"label_high_score", nil);
    [self.view addSubview:highScoreLabel];
    
    UILabel *highScoreLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(20, paddingY - 30+paddingY_, 280, 30)];
    highScoreLabel_.backgroundColor = [UIColor clearColor];
    highScoreLabel_.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    highScoreLabel_.textAlignment = NSTextAlignmentCenter;
    highScoreLabel_.font = [UIFont fontWithName:@"Helvetica" size:20];
    highScoreLabel_.text = self.highScore;
    [self.view addSubview:highScoreLabel_];
    
    /*
    // mail
    UIButton *mail = [[UIButton alloc] init];
    mail.frame = CGRectMake(30+(50+20)*0, paddingY + 50, 50, 50);
    mail.layer.cornerRadius = 10;
    mail.clipsToBounds = YES;
    [mail setBackgroundImage:[UIImage imageNamed:@"mail.png"] forState:UIControlStateNormal];
    [mail addTarget:self action:@selector(mail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mail];
    
    // line
    UIButton *line = [[UIButton alloc] init];
    line.frame = CGRectMake(30+(50+20)*1, paddingY + 50, 50, 50);
    line.layer.cornerRadius = 10;
    line.clipsToBounds = YES;
    [line setBackgroundImage:[UIImage imageNamed:@"line.png"] forState:UIControlStateNormal];
    [line addTarget:self action:@selector(line) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:line];
    
    // twitter
    UIButton *twitter = [[UIButton alloc] init];
    twitter.frame = CGRectMake(30+(50+20)*2, paddingY + 50, 50, 50);
    twitter.layer.cornerRadius = 10;
    twitter.clipsToBounds = YES;
    [twitter setBackgroundImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
    [twitter addTarget:self action:@selector(twitter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitter];
    
    // facebook
    UIButton *facebook = [[UIButton alloc] init];
    facebook.frame = CGRectMake(30+(50+20)*3, paddingY + 50, 50, 50);
    facebook.layer.cornerRadius = 10;
    facebook.clipsToBounds = YES;
    [facebook setBackgroundImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
    [facebook addTarget:self action:@selector(facebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebook];
     */
    
    // シェア
    UIButton *share = [[UIButton alloc] init];
    share.frame = CGRectMake(70, paddingY + 50, self.view.frame.size.width - 70*2, 50);
    share.backgroundColor = [UIColor colorWithRed:0.1 green:0.9 blue:0.1 alpha:1];
    share.layer.cornerRadius = 8;
    share.clipsToBounds = YES;
    share.font = [UIFont fontWithName:@"Helvetica" size:18];
    [share setTitle:NSLocalizedString(@"button_share", nil) forState:UIControlStateNormal];
    [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [share setTitle:NSLocalizedString(@"button_share", nil) forState:UIControlStateHighlighted];
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:share];
    
    // もう一度
    UIButton *replay = [[UIButton alloc] init];
    replay.frame = CGRectMake(70, paddingY + 50 + 70, self.view.frame.size.width - 70*2, 50);
    replay.backgroundColor = [UIColor colorWithRed:1 green:0.7 blue:0.2 alpha:1];
    replay.layer.cornerRadius = 8;
    replay.clipsToBounds = YES;
    replay.font = [UIFont fontWithName:@"Helvetica" size:18];
    [replay setTitle:NSLocalizedString(@"button_replay", nil) forState:UIControlStateNormal];
    [replay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [replay setTitle:NSLocalizedString(@"button_replay", nil) forState:UIControlStateHighlighted];
    [replay addTarget:self action:@selector(replay:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:replay];
    
    // もどる
    UIButton *title = [[UIButton alloc] init];
    title.frame = CGRectMake(70, paddingY + 50 + 70*2, self.view.frame.size.width - 70*2, 50);
    title.backgroundColor = [UIColor colorWithRed:1 green:0.2 blue:0.2 alpha:1];
    title.layer.cornerRadius = 8;
    title.clipsToBounds = YES;
    title.font = [UIFont fontWithName:@"Helvetica" size:18];
    [title setTitle:NSLocalizedString(@"button_title", nil) forState:UIControlStateNormal];
    [title setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [title setTitle:NSLocalizedString(@"button_title", nil) forState:UIControlStateHighlighted];
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
    gameViewController = [[GameViewController alloc] init];
    gameViewController.view.frame = self.view.frame;
    gameViewController.mainViewController = self.mainViewController;
    [self.view addSubview:gameViewController.view];
}

- (void)title:(id)sender {
    MainViewController *mainViewController = self.mainViewController;
    UIView *view = [[mainViewController.view subviews] lastObject];
    [view removeFromSuperview];
}

- (void)mail {
    NSString *string = [NSString stringWithFormat:@"%@ %@ %@",
                        NSLocalizedString(@"alert_share_contents", nil),
                        [NSString stringWithFormat:@"「%@」",self.score],
                        [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"alert_share_url", nil),APP_ID]];
    
    [CustomAlertView alertWithTitle:NSLocalizedString(@"alert_share_title_sms", nil)
                            message:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"alert_share_message", nil),string]
                  cancelButtonTitle:@"cancel"
                       clickedBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                           if (buttonIndex == 1) {
                               NSString *LineUrlString = [NSString stringWithFormat:@"sms:"];
                               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LineUrlString]];
                           }
                       } cancelBlock:^(UIAlertView *alertView) {
                       } otherButtonTitles:[[NSArray alloc] initWithObjects:@"OK", nil]];
}

- (void)line {
	NSString *string = [NSString stringWithFormat:@"%@ %@ %@",
                        NSLocalizedString(@"alert_share_contents", nil),
                        [NSString stringWithFormat:@"「%@」",self.score],
                        [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"alert_share_url", nil),APP_ID]];
    
    NSString *escapedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 kCFAllocatorDefault,
                                                                                 (CFStringRef)string,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
    
    NSString *LineUrlString = [NSString stringWithFormat:@"line://msg/text/%@",escapedString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LineUrlString]];
}

- (void)twitter {
    NSString *string = [NSString stringWithFormat:@"%@ %@ %@ %@",
                        NSLocalizedString(@"alert_share_contents", nil),
                        [NSString stringWithFormat:@"「%@」",self.score],
                        [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"alert_share_url", nil),APP_ID],
                        [NSString stringWithFormat:@"#%@ %@",NSLocalizedString(@"app_name", nil),@"#アプリ #ゲーム #暇つぶし #中毒 #iphone"]];
    
    NSString *escapedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                   kCFAllocatorDefault,
                                                                                                   (CFStringRef)string,
                                                                                                   NULL,
                                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8));
    
    NSString *LineUrlString = [NSString stringWithFormat:@"twitter://post?message=%@",escapedString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LineUrlString]];
}

- (void)facebook {
    NSString *string = [NSString stringWithFormat:@"%@",
                        [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"alert_share_url", nil),APP_ID]];
    
    NSString *escapedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                   kCFAllocatorDefault,
                                                                                                   (CFStringRef)string,
                                                                                                   NULL,
                                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8));
    
    NSString *LineUrlString = [NSString stringWithFormat:@"http://www.facebook.com/share.php?u=%@",escapedString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LineUrlString]];
}

- (void)share {
    NSString *shareText = [NSString stringWithFormat:@"%@ %@",
                           NSLocalizedString(@"alert_share_contents", nil),
                           [NSString stringWithFormat:@"「%@」",self.score]];
    NSURL *shareURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/jp/app/id%@",APP_ID]];
    NSArray *activityItems = @[ shareText, shareURL];
    //UIImage *resultImage = [UIImage imageNamed:@"icon.png"];
    //NSArray *activityItems = @[resultImage, shareText, shareURL];
    //NSArray *applicationActivities = @[[[LINEActivity alloc] init]];
    NSArray *applicationActivities = nil;
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                         applicationActivities:applicationActivities];
    
    activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *error) {
        if (error) {
            NSLog(@"error:%@", error);
        }
        else {
            if (completed){
                NSLog(@"completed:%@",activityType);
                if(activityType == UIActivityTypePostToTwitter){
                    NSLog(@"twitterUsed");
                }
                else if(activityType == UIActivityTypePostToFacebook){
                    NSLog(@"facebookUsed");
                }
                else {
                }
            }
            else {
            }
        }
    };
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}
@end
