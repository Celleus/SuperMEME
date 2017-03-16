//
//  Player.h
//  Circle
//
//  Created by Celleus on 2014/06/11.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PLAYER_STOP     0
#define PLAYER_MOVE_L   1
#define PLAYER_MOVE_R   11
#define PLAYER_BLOCK    3
#define PLAYER_JUMP     4
#define PLAYER_DIE      5

@interface Player : UIImageView

@property (readwrite) CGFloat speedY;

@property (readwrite) CGFloat speedVX;
@property (readwrite) CGFloat speedVY;

@property (readwrite) CGFloat jumpPow;
@property (readwrite) CGFloat jumpCountMax;
@property (readwrite) CGFloat jumpCount;

@property (readwrite) BOOL flag;

- (void)setPlayserIamge:(int)image;

@end
