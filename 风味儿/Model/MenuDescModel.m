//
//  MenuDescModel.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuDescModel.h"

@implementation MenuDescModel
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    
    if ([propertyName isEqualToString:@"desc"]) {
        propertyName = @"description";
    }
    return propertyName;
}
@end
