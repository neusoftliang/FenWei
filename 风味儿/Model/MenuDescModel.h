//
//  MenuDescModel.h
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface MenuDescModel : BaseModel

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger fcount;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *food;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger rcount;

@end
