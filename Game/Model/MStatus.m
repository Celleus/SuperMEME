//
//  MStatus.m
//  Game
//
//  Created by Celleus on 2014/08/03.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "MStatus.h"

@implementation MStatus

static NSString *table = @"status";

- (id)init {
    self = [super init];
    self.table = table;
    return self;
}

+ (BOOL)select {
    FMDatabase *db = [AppModel selectDatabaseDocument];
    FMResultSet *results = [[FMResultSet alloc] init];
    
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ;",table];
    results = [db executeQuery:sql];
    while ( [results next] ) {
        return YES;
    }
    [db close];
    
    return NO;
}

+ (NSMutableDictionary *)select:(NSString *)key {
    FMDatabase *db = [AppModel selectDatabaseDocument];
    FMResultSet *results = [[FMResultSet alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE key = '%@';",table,key];
    results = [db executeQuery:sql];
    while ( [results next] ) {
        [dic setObject:[results objectForColumnIndex:0] forKey:@"id"];
        [dic setObject:[results objectForColumnIndex:1] forKey:@"key"];
        [dic setObject:[results objectForColumnIndex:2] forKey:@"value"];
        return dic;
    }
    [db close];
    
    return dic;
}

+ (BOOL)insert:(NSString *)key value:(NSString *)value {
    FMDatabase *db = [AppModel selectDatabaseDocument];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (key,value) VALUES (?,?);",table];
    if([db executeUpdate:sql,key,value]) return YES;
    
    return NO;
}

+ (BOOL)update:(NSString *)key value:(NSString *)value {
    FMDatabase *db = [AppModel selectDatabaseDocument];
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET value = ? WHERE key = '%@';",table,key];
    if([db executeUpdate:sql,value]) return YES;
    
    return NO;
}

@end
