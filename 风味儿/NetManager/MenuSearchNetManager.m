//
//  MenuSearchNetManager.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuSearchNetManager.h"

@implementation MenuSearchNetManager
+(id)getMenuDescBySearchName:(NSString *)menuName completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *URLPath = [NSString stringWithFormat:@"http://www.tngou.net/api/cook/name?name=%@",menuName];
    NSString *utf = [URLPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self GET:utf parameters:nil completionHandle:^(id model, NSError *error) {
        completionHandle([MenuSearchModel parse:model],error);
    }];
}
@end
