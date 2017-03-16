//
//  RootViewController.m
//  Game
//
//  Created by Celleus on 2014/08/02.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"

@interface RootViewController ()  {
    MainViewController *mainViewController;
}

@end

@implementation RootViewController

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

    mainViewController = [[MainViewController alloc] init];
    mainViewController.view.frame = self.view.frame;
    [self.view addSubview:mainViewController.view];
    
    // ナビボタンの色
    [UINavigationBar appearance].tintColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1]; //文字色
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1]}; //タイトルの色
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
