//
//  MenuDescNetManager.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuDescNetManager.h"

@implementation MenuDescNetManager
+(id)getMenuDescByListID:(NSInteger)list_id completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *URLPath = [NSString stringWithFormat:@"http://www.tngou.net/api/cook/show?id=%ld",list_id];
    return [self GET:URLPath parameters:nil completionHandle:^(id model, NSError *error) {
        completionHandle([MenuDescModel parse:model],error);
    }];
}
@end
