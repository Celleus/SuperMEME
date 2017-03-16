//
//  GameViewController.h
//  Game
//
//  Created by Celleus on 2014/08/07.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface GameViewController : UIViewController

@property (nonatomic,strong) MainViewController *mainViewController;

- (void)clearScaffold;
- (void)restart;
- (void)memeRealTimeModeDataReceived:(MEMERealTimeData *)data;

@end
