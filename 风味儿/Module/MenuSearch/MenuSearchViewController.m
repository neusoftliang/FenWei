//
//  MenuSearchViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/8.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuSearchViewController.h"
#import "MenuTableView.h"
#import "MenuSearchNetManager.h"
@interface MenuSearchViewController ()<UISearchBarDelegate>
@property (strong,nonatomic) MenuTableView *menuListTabel;
@end

@implementation MenuSearchViewController

- (MenuTableView *)menuListTabel {
    if(_menuListTabel == nil) {
        _menuListTabel = [[MenuTableView alloc] init];
        [self.view addSubview:_menuListTabel];
        [_menuListTabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(108);
            make.right.bottom.left.mas_equalTo(0);
        }];
    }
    return _menuListTabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
}
#pragma mark --- UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn=[searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [MenuSearchNetManager getMenuDescBySearchName:searchText completionHandle:^(id model, NSError *error) {
        MenuSearchModel *searListModel = (MenuSearchModel*)model;
        self.menuListTabel.FoodList_array = searListModel.tngou;
        [self.menuListTabel reloadData];
    }];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [MenuSearchNetManager getMenuDescBySearchName:searchBar.text completionHandle:^(id model, NSError *error) {
        MenuSearchModel *searListModel = (MenuSearchModel*)model;
        self.menuListTabel.FoodList_array = searListModel.tngou;
        [self.menuListTabel reloadData];
    }];
}

@end
