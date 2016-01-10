//
//  FoodMaterialsModel.h
//  风味儿
//
//  Created by neusoftliang on 16/1/9.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FoodMaterialsModel : NSObject
@property (assign,nonatomic) NSInteger food_ID;
@property (assign,nonatomic) NSInteger material_ID;
@property (strong,nonatomic) NSString *materialName ;
@property (strong,nonatomic) NSString *materialUnit ;
@property (assign,nonatomic) NSInteger materialNum;
@end
