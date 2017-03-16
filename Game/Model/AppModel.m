//
//  AppModel.m
//  Game
//
//  Created by Celleus on 2014/08/03.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel


static FMDatabase *document = nil;
static FMDatabase *caches = nil;

+ (FMDatabase *)selectDatabaseDocument {
    if (document) return document;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = [paths objectAtIndex:0];
    dir = [dir stringByAppendingPathComponent:APP_ID];
    dir = [dir stringByAppendingPathComponent:FILE_PATH_DOCUMENT_DB];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dir]) {
        [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    document = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",APP_ID]]];
    
    return document;
}

+ (FMDatabase *)selectDatabaseCaches {
    if (caches) return caches;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString *dir = [paths objectAtIndex:0];
    dir = [dir stringByAppendingPathComponent:APP_ID];
    dir = [dir stringByAppendingPathComponent:FILE_PATH_CACHE_DB];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dir]) {
        [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    caches = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",APP_ID]]];
    
    return caches;
}

+ (void)beginTransactionDD {
    document = [self selectDatabaseDocument];
    [document open];
    [document beginTransaction];
}

+ (void)endTransactionDD:(BOOL)boolean {
    if (boolean) {
        [document commit];
        NSLog(@"コミット");
    }
    else {
        [document rollback];
        NSLog(@"ロールバック");
    }
    [document close];
}

+ (void)beginTransactionCD {
    caches = [self selectDatabaseCaches];
    [caches open];
    [caches beginTransaction];
}

+ (void)endTransactionCD:(BOOL)boolean {
    if (boolean) {
        [caches commit];
        NSLog(@"コミット");
    }
    else {
        [caches rollback];
        NSLog(@"ロールバック");
    }
    [caches close];
}

+ (void)debugerDD:(NSString *)table {
    FMDatabase *db = [AppModel selectDatabaseDocument];
    NSString *sql = [[NSString alloc] init];
    FMResultSet *results = [[FMResultSet alloc] init];
    [db open];
    
    sql = [NSString stringWithFormat:@"SELECT * FROM %@;",table];
    results = [db executeQuery:sql];
    while ( [results next] ) {
        NSLog(@"%@", results);
    }
    
    [db close];
}

+ (void)debugerCD:(NSString *)table {
    NSLog(@"**************** debuger ***************** %@",table);
    FMDatabase *db = [AppModel selectDatabaseCaches];
    NSString *sql = [[NSString alloc] init];
    FMResultSet *results = [[FMResultSet alloc] init];
    [db open];
    
    sql = [NSString stringWithFormat:@"SELECT * FROM %@;",table];
    results = [db executeQuery:sql];
    while ( [results next] ) {
        NSLog(@"0 = %@", [results objectForColumnIndex:0]);
        NSLog(@"1 = %@", [results objectForColumnIndex:1]);
        NSLog(@"2 = %@", [results objectForColumnIndex:2]);
        NSLog(@"3 = %@", [results objectForColumnIndex:3]);
        NSLog(@"4 = %@", [results objectForColumnIndex:4]);
    }
    
    [db close];
    NSLog(@"**************** debuger *****************");
}

@end
