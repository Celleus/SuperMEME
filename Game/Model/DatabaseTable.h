//
//  DatabaseTable.h
//  Game
//
//  Created by Celleus on 2014/08/03.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#import "AppModel.h"

@interface DatabaseTable : AppModel

// テーブル作成
- (void)createTable;
// テーブル削除
- (void)dropTable;
// テーブル初期設定
- (void)initTable;

@end
