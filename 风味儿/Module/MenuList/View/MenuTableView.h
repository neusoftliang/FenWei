//
//  MenuTableView.h
//  风味儿
//
//  Created by neusoftliang on 16/1/7.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *FoodList_array;
@end
