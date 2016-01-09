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
@property (strong,nonatomic) UISearchBar *searchBar;
@end

@implementation MenuSearchViewController

- (MenuTableView *)menuListTabel {
    if(_menuListTabel == nil) {
        _menuListTabel = [[MenuTableView alloc] init];
        [self.view addSubview:_menuListTabel];
        [_menuListTabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(108);
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-44);
        }];
    }
    return _menuListTabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    self.searchBar = searchBar;
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeyDone;
    searchBar.placeholder = @"请输入菜名";
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
    
    if (![searchText isEqualToString:@""]) {
        [MenuSearchNetManager getMenuDescBySearchName:searchText completionHandle:^(id model, NSError *error) {
            MenuSearchModel *searListModel = (MenuSearchModel*)model;
            self.menuListTabel.FoodList_array = searListModel.tngou;
            [self.menuListTabel reloadData];
        }];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.menuListTabel.FoodList_array = nil;
    [self.menuListTabel removeFromSuperview];
    [self searchBarCancelButtonClicked:self.searchBar];
}
@end
