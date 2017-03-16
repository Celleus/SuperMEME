//
//  MStatus.h
//  Game
//
//  Created by Celleus on 2014/08/03.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "AppModel.h"

@interface MStatus : AppModel


+ (BOOL)select;
+ (NSMutableDictionary *)select:(NSString *)key;
+ (BOOL)insert:(NSString *)key value:(NSString *)value;
+ (BOOL)update:(NSString *)key value:(NSString *)value;

@end
