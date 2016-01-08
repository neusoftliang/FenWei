//
//  MenuListModel.h
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class Tngou;
@interface MenuListModel : BaseModel

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<Tngou *> *tngou;

@end
@interface Tngou : BaseModel

@property (nonatomic, assign) NSInteger fcount;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger rcount;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *food;

@end

