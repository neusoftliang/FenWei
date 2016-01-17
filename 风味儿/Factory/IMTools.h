//
//  IMTools.h
//  风味儿
//
//  Created by neusoftliang on 16/1/15.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMTools : NSObject
/**
 *  登录方法
 */

+(void)loginManagerByUserName:(NSString *)userName AnduserPasswd:(NSString *)passwd returnBlock:(void(^)(NSDictionary *userInfo,EMError *error)) loginStatus;
/**
*  注册方法
*/
+(void)registerManagerByUserName:(NSString *)userName AnduserPasswd:(NSString *)passwd returnBlock:(void(^)(BOOL isSuccess,EMError *error)) registerStatus;
@end
