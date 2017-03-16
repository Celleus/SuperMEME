//
//  DatabaseTable.m
//  Game
//
//  Created by Celleus on 2014/08/03.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "DatabaseTable.h"

@implementation DatabaseTable

- (void)createTable{
    NSString *sql = [[NSString alloc] init];
    FMDatabase *db = [[FMDatabase alloc] init];
    
    //************************************************************************************************************************
    // ドキュメントDB
    //************************************************************************************************************************
    db = [AppModel selectDatabaseDocument];
    [db open];
    
    // Status
    sql = @"CREATE TABLE IF NOT EXISTS status ( id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT, value TEXT)";
    [db executeUpdate:sql];
    
    [db close];
    
    //************************************************************************************************************************
    // キャッシュDB
    //************************************************************************************************************************
    db = [AppModel selectDatabaseCaches];
    [db open];
    
    [db close];
}

- (void)dropTable{
    //NSString *sql = [[NSString alloc] init];
    FMDatabase *db = [[FMDatabase alloc] init];
    
    //************************************************************************************************************************
    // ドキュメントDB
    //************************************************************************************************************************
    db = [AppModel selectDatabaseDocument];
    [db open];
    [db close];
    
    //************************************************************************************************************************
    // キャッシュDB
    //************************************************************************************************************************
    db = [AppModel selectDatabaseCaches];
    [db open];
    [db close];
}

- (void)initTable {
}

@end
