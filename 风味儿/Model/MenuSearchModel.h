//
//  MenuSearchModel.h
//  风味儿
//
//  Created by neusoftliang on 16/1/8.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuListModel.h"
@interface MenuSearchModel : NSObject
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSArray<Tngou *> *tngou;
@end
