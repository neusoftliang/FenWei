//
//  MenuListModel.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuListModel.h"

@implementation MenuListModel


+ (NSDictionary *)objectClassInArray{
    return @{@"tngou" : [Tngou class]};
}
@end
@implementation Tngou

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    
    if ([propertyName isEqualToString:@"desc"]) {
        propertyName = @"description";
    }
    return propertyName;
}
@end


