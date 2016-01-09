//
//  DatabaseManager.h
//  风味儿
//
//  Created by neusoftliang on 16/1/9.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject
typedef enum{
    /**
     *  插入数据
     */
    INSERTDATA = 0,
    /**
     *  删除数据
     */
    DELETEDATA,
    /**
     *  修改数据
     */
    UPDATEDATA,
    /**
     *  查找数据
     */
    SELECTDATA
}dbHandle;
/**
 *  打开数据库
 */
+(void)openDatabase:(void(^)(FMDatabase *db,BOOL isSuccess))openBlock;
/**
 *  操作数据库
 */
+(BOOL)excuteDatabase:(FMDatabase *)db By:(id)data FuncSelect:(dbHandle)handle;
/**
 *  关闭数据库
 */
+(void)closeDatabase:(FMDatabase *)db;
@end
