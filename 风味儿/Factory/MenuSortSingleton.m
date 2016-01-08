//
//  MenuSortSingleton.m
//  风味儿
//
//  Created by neusoftliang on 16/1/7.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuSortSingleton.h"
#import "MenuSortModel.h"
@implementation MenuSortSingleton
+(NSArray *)getMenuSort
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MenuList" ofType:@"plist"];
    static NSMutableArray *menuArray = nil;
    if (menuArray==nil) {
        menuArray = [NSMutableArray array];
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
        NSArray *array = dic[@"tngou"];
        for (NSDictionary *dict in array) {
            MenuSortModel *sort = [MenuSortModel new];
            sort.sortName = dict[@"name"];
            sort.sort_ID = [dict[@"id"] integerValue];
            [menuArray addObject:sort];
        }
    }
    return [menuArray copy];
}
@end
