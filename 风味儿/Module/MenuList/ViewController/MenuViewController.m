//
//  MenuViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/7.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableView.h"
#import "MenuListNetManager.h"
#import "MenuListModel.h"
#import "UIScrollView+Refresh.h"
@interface MenuViewController ()
@property (strong,nonatomic)MenuTableView *menuTable;
@property (assign,nonatomic) NSInteger pageNum;
@property (strong,nonatomic) NSMutableArray *menuList_mutaArray;
@property (assign,nonatomic) NSInteger totalNum;
@end

@implementation MenuViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self configTableView];
    [self getDataFromServer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMore];
}

/**
 *  下拉刷新
 */

-(void)loadMore
{
    __weak typeof(self) weakSelf = self;
    [self.menuTable addFooterRefresh:^{
        weakSelf.pageNum++;
        [weakSelf getDataFromServer];
    }];
    [self.menuTable beginFooterRefresh];
}

#pragma mark --- config 菜单列表
- (NSMutableArray *)menuList_mutaArray {
    if(_menuList_mutaArray == nil) {
        _menuList_mutaArray = [NSMutableArray array];
    }
    return _menuList_mutaArray;
}
- (MenuTableView *)menuTable {
    if(_menuTable == nil) {
        _menuTable = [[MenuTableView alloc] init];
        [self.view addSubview:_menuTable];
        [_menuTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _menuTable;
}
-(void) configTableView
{
    self.pageNum = 1;
}

-(void)getDataFromServer
{
    [MenuListNetManager getMenuListBySortID:self.sortModel.sort_ID AndPage:self.pageNum completionHandle:^(id model, NSError *error) {
        MenuListModel* menuListModel =(MenuListModel*) model;
        self.totalNum = menuListModel.total;
        [self.menuList_mutaArray addObjectsFromArray:menuListModel.tngou];
        self.menuTable.FoodList_array = self.menuList_mutaArray;
        [self endFootRefre];
        [self.menuTable reloadData];
    }];
}


-(void)endFootRefre
{
    if (self.menuList_mutaArray.count>=self.totalNum) {
        [self.menuTable endFooterRefresh];
        MBProgressHUD *progressHUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressHUD.mode = MBProgressHUDModeText;
        progressHUD.labelText = @"已经全部加载完毕！";
        [progressHUD hide:YES afterDelay:2];
        [self.menuTable.mj_footer removeFromSuperview];
    }
    [self.menuTable endFooterRefresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [self clearTempSDImg];
}
/**
 *  SDWebImage缓存的清理
 */
-(void)clearTempSDImg
{
    CGFloat temp = 1.0*[SDImageCache sharedImageCache].getSize/1024/1024;
    NSLog(@"缓存%.2lfM",temp);
    if (temp>=5.0) {
        [[SDImageCache sharedImageCache]clearDisk];
    }
    
}
@end
