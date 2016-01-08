//
//  NSObject+AFNet.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NSObject+AFNet.h"

@implementation NSObject (AFNet)

+(id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completionHandle
{
    return [[AFHTTPRequestOperationManager manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"resp---afnet%@",responseObject);
        completionHandle(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandle(nil,error);
    }];
}

+(id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completionHandle
{
    return [[AFHTTPRequestOperationManager manager] POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionHandle(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandle(nil,error);
    }];
}

@end
