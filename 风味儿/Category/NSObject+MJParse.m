//
//  NSObject+MJParse.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NSObject+MJParse.h"
#import <MJExtension.h>
@implementation NSObject (MJParse)

+(id)parse:(id)responseObj
{
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:responseObj];
    }else if ([responseObj isKindOfClass:[NSArray class]]){
        return [self mj_objectArrayWithKeyValuesArray:responseObj];
    }
    return responseObj;
}

@end
