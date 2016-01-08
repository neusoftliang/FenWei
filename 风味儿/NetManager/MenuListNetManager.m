//
//  MenuListNetManager.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuListNetManager.h"

@implementation MenuListNetManager

+(id)getMenuListBySortID:(NSInteger)sort_id AndPage:(NSInteger)page kCompletionHandle
{
    
    NSString *URLPath = [NSString stringWithFormat:@"%@list?id=%ld&rows=10&page=%ld",kBaseURLPath,sort_id,page];
    return [self GET:URLPath parameters:nil completionHandle:^(id model, NSError *error) {
        NSLog(@"manager---%@",model);
        completionHandle([MenuListModel parse:model], error);
    }];
    
}

@end
