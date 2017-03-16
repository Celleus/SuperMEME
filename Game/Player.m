//
//  Player.m
//  Game
//
//  Created by Celleus on 2014/06/11.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.speedY = Y;
        
        self.speedVX = 0;
        self.speedVY = 0;
        
        self.jumpPow = TOUCH_JUMP_POW;
        self.jumpCountMax = MAX_JUMP_COUNT;
        self.jumpCount = self.jumpCountMax;
        
        self.flag = YES;
    }
    return self;
}

- (void)setPlayserIamge:(int)image {
    self.tag = image;
    
    if (image != PLAYER_MOVE_L && image != PLAYER_MOVE_R) {
        [self stopAnimating];
    }
    
    if (image == PLAYER_STOP) {
        if (self.speedVX <= 0) {
            self.image = [UIImage imageNamed:@"11.png"];
        }
        else {
            self.image = [UIImage imageNamed:@"1.png"];
        }
    }
    else if (image == PLAYER_MOVE_L) {
        self.animationImages = @[[UIImage imageNamed:@"11.png"],[UIImage imageNamed:@"12.png"]];
        self.animationRepeatCount = 0;
        self.animationDuration = 0.2;
        [self startAnimating];
    }
    else if (image == PLAYER_MOVE_R) {
    
        self.animationImages = @[[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"]];
        self.animationRepeatCount = 0;
        self.animationDuration = 0.2;
        [self startAnimating];
    }
    else if (image == PLAYER_BLOCK) {
        if (self.speedVX <= 0) {
            self.image = [UIImage imageNamed:@"13.png"];
        }
        else {
            self.image = [UIImage imageNamed:@"3.png"];
        }
    }
    else if (image == PLAYER_JUMP) {
        if (self.speedVX <= 0) {
            self.image = [UIImage imageNamed:@"14.png"];
        }
        else {
            self.image = [UIImage imageNamed:@"4.png"];
        }
    }
    else if (image == PLAYER_DIE) {
        if (self.speedVX <= 0) {
            self.image = [UIImage imageNamed:@"15.png"];
        }
        else {
            self.image = [UIImage imageNamed:@"5.png"];
        }
    }
}


@end
