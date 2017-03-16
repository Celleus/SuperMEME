//
//  AppModel.h
//  Game
//
//  Created by Celleus on 2014/08/03.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "FMDatabase.h"

@interface AppModel : FMDatabase

@property (nonatomic,copy) NSString *table;

+ (FMDatabase *)selectDatabaseDocument;
+ (FMDatabase *)selectDatabaseCaches;

+ (void)beginTransactionDD;
+ (void)endTransactionDD:(BOOL)boolean;
+ (void)beginTransactionCD;
+ (void)endTransactionCD:(BOOL)boolean;

+ (void)debugerDD:(NSString *)table;
+ (void)debugerCD:(NSString *)table;

@end
