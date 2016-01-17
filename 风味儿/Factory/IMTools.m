//
//  IMTools.m
//  风味儿
//
//  Created by neusoftliang on 16/1/15.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "IMTools.h"

@implementation IMTools
+(void)registerManagerByUserName:(NSString *)userName AnduserPasswd:(NSString *)passwd returnBlock:(void (^)(BOOL ,  EMError*))registerStatus
{
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager registerNewAccount:userName password:passwd error:&error];
    if (isSuccess) {
        NSLog(@"注册成功");
    }
    registerStatus(isSuccess,error);
}
+(void)loginManagerByUserName:(NSString *)userName AnduserPasswd:(NSString *)passwd returnBlock:(void(^)(NSDictionary *userInfo,EMError *error)) loginStatus
{
    EMError *error = nil;
    NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:userName password:passwd error:&error];
    if (!error && loginInfo) {
        NSLog(@"登陆成功");
    }
    loginStatus(loginInfo,error);
}
@end
