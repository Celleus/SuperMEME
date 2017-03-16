//
//  GameOverViewController.h
//  Game
//
//  Created by Celleus on 2014/08/07.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface GameOverViewController : UIViewController

@property (nonatomic,strong) MainViewController *mainViewController;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *highScore;

@end
