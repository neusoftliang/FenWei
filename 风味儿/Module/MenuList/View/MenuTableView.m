//
//  MenuTableView.m
//  风味儿
//
//  Created by neusoftliang on 16/1/7.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuTableView.h"
#import "TableViewCell.h"
#import "MenuListModel.h"
#import "FoodShowView.h"
@interface MenuTableView()
@end
@implementation MenuTableView

-(instancetype)init
{
    NSLog(@"init");
    if (self = [super init]) {
        [self registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"food"];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark --- UITableView协议

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"section");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.FoodList_array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"food" forIndexPath:indexPath];
    Tngou *foodList = self.FoodList_array[indexPath.row];
    NSLog(@"cell---%@",foodList.name);
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",foodList.img]];
    [cell.foodImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeImage"]];
    cell.foodName.text = foodList.name;
    cell.foodDesc.text = foodList.food;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIWindow *mainWindow = [[[UIApplication sharedApplication] windows]firstObject];
    FoodShowView *food = [[FoodShowView alloc]init];
    Tngou *foodList = self.FoodList_array[indexPath.row];
    food.food_ID = foodList.id;
    [mainWindow addSubview:food];
    [food mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
@end
