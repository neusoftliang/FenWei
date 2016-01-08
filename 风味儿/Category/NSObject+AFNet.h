//
//  NSObject+AFNet.h
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#define kCompletionHandle  completionHandle:(void(^)(id model, NSError *error))completionHandle;

@interface NSObject (Network)
/**
 *  Get方式请求网络数据
 *
 */
+ (id)GET:(NSString *)path parameters:(NSDictionary *)params kCompletionHandle
/**
 *  POST方式请求网络数据
 *
 */
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params kCompletionHandle

@end
