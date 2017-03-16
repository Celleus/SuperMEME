//
//  Const.h
//  Game
//
//  Created by Celleus on 2014/08/02.
//  Copyright (c) 2014年 Game. All rights reserved.
//

#ifndef SosuuTap_Const_h
#define SosuuTap_Const_h

#define FPS 50.0f           // FPS（画面の更新速度）

#define MEME_X 0.2          // キャラの横軸移動速度
#define MAX_VX 6            // キャラの最大横軸移動速度
#define Y 4                 // キャラの落下速度
#define MEME_JUMP_POW 0.06   //　MEMEによるキャラのジャンプ力
#define TOUCH_JUMP_POW 2    //　タッチによるキャラのジャンプ力
#define MAX_JUMP_COUNT 1    //　キャラの最大連続ジャンプ数
#define PLAYER_SIZE 40      // キャラのサイズ（足場の当たり判定に影響）

//**************************************************
// DB
//**************************************************

#define FILE_PATH_DOCUMENT_DB           @"DocumentDB"
#define FILE_PATH_CACHE_DB              @"CacheDB"
#define DB_NAME                         @"main"

#endif
