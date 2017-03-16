//
//  Player.m
//  Circle
//
//  Created by Celleus on 2014/06/11.
//  Copyright (c) 2014年 Circle. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:0.7 blue:0.2 alpha:1];
        self.layer.cornerRadius = frame.size.width / 2;
        self.clipsToBounds = YES;
        
        
        self.speedX = 4;
        self.speedY = 4;
        
        self.speedVX = 0;
        self.speedVY = 0;
        
        self.jumpPow = 2;
        self.jumpCountMax = 1;
        self.jumpCount = self.jumpCountMax;
        
        self.flag = YES;
    }
    return self;
}


@end
