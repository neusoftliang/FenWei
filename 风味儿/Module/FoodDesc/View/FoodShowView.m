//
//  FoodShowView.m
//  风味儿
//
//  Created by neusoftliang on 16/1/8.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "FoodShowView.h"
#import "MenuDescModel.h"
#import "MenuDescNetManager.h"
#import <WebKit/WebKit.h>
@interface FoodShowView ()
@property (strong,nonatomic) MenuDescModel *food;
@property (strong,nonatomic) UILabel *foodName_label;
@property (strong,nonatomic) UIImageView *foodImageView;
@property (strong,nonatomic) WKWebView *foodDescWebView;
@end

@implementation FoodShowView

-(void)setFood_ID:(NSInteger)food_ID
{
    NSLog(@"foodID%lu",food_ID);
    [MenuDescNetManager getMenuDescByListID:food_ID completionHandle:^(id model, NSError *error) {
        MenuDescModel *foodDescModel = (MenuDescModel*)model;
        _foodName_label.text = foodDescModel.name;
        
        [_foodImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImagePath,foodDescModel.img]] placeholderImage:[UIImage imageNamed:@"placeImage"]];
        [_foodDescWebView loadHTMLString:
         [NSString stringWithFormat:
          @"<html> \n"
          "<head> \n"
          "<style type=\"text/css\"> \n"
          "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
          "</style> \n"
          "</head> \n"
          "<body>%@</body> \n"
          "</html>",
           @"宋体", 40.0,nil,foodDescModel.message] baseURL:nil];
    }];
}

-(instancetype)init
{
    if (self = [super init])
    {
#pragma mark --- 配置背景图片
        UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
        [self insertSubview:bgImageView atIndex:0];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
#pragma mark --- 配置菜单
        UIView *foodView = [[UIView alloc]init];
        foodView.backgroundColor = [UIColor whiteColor];
        //加阴影
        foodView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        foodView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        foodView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        foodView.layer.shadowRadius = 4;//阴影半径，默认3
        [self addSubview:foodView];
        [foodView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(80,20,80,20));
        }];
#pragma mark --- 配置label
        _foodName_label = [[UILabel alloc]init];
        [foodView addSubview:_foodName_label];
        [_foodName_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        _foodName_label.textAlignment = NSTextAlignmentCenter;
#pragma mark --- 配置ImageView
        _foodImageView = [[UIImageView alloc]init];
        [foodView addSubview:_foodImageView];
        [_foodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_foodName_label.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(100);
        }];
#pragma mark --- 配置UIWebView
        _foodDescWebView = [[WKWebView alloc]init];
        [foodView addSubview:_foodDescWebView];
        [_foodDescWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_foodImageView.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(0);
            
        }];
#pragma mark --- 配置按钮
        UIButton *closeBtn = [[UIButton alloc]init];
        UIButton *favouriteBtn = [[UIButton alloc]init];
        [closeBtn bk_addEventHandler:^(id sender) {
            
            [self removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [favouriteBtn setBackgroundImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
        [self addSubview:closeBtn];
        [self addSubview:favouriteBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(foodView.mas_left);
            make.centerY.mas_equalTo(foodView.mas_top);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [favouriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(foodView.mas_right);
            make.centerY.mas_equalTo(foodView.mas_top);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return self;
}
@end
