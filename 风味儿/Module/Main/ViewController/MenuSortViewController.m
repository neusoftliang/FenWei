//
//  MenuSortViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MenuSortViewController.h"
#import "MenuListNetManager.h"
#import "MenuSortCell.h"
#import "MenuSortSingleton.h"
#import "MenuSortModel.h"
#import "MenuViewController.h"
#define kMargin 10
@interface MenuSortViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) UICollectionView *menuCollection;
@property (strong,nonatomic) NSArray *MenuSort_arr;
@end

@implementation MenuSortViewController
/**
 *  获取食疗菜谱单
 */
- (NSArray *)MenuSort_arr {
    if(_MenuSort_arr == nil) {
        _MenuSort_arr = [MenuSortSingleton getMenuSort];
    }
    return _MenuSort_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCollectionView];
}



#pragma mark --- 配置collectionView
- (UICollectionView *)menuCollection {
    if(_menuCollection == nil) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _menuCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.view addSubview:_menuCollection];
        [_menuCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        _menuCollection.backgroundColor = [UIColor clearColor];
        _menuCollection.delegate = self;
        _menuCollection.dataSource = self;
    }
    return _menuCollection;
}

-(void)configCollectionView
{
    self.menuCollection.hidden = NO;
    [self.menuCollection registerNib:[UINib nibWithNibName:@"MenuSortCell" bundle:nil] forCellWithReuseIdentifier:@"menu"];
}

#pragma mark --- CollectionView协议

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 23;
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuSortCell *cell = (MenuSortCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"menu" forIndexPath:indexPath];
    MenuSortModel *sortModel = self.MenuSort_arr[indexPath.row];
    cell.label_menuName.text = sortModel.sortName;
    //cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}


//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=(self.view.bounds.size.width-4*kMargin)/3;
    return CGSizeMake(height, height);
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuViewController *menuList = [MenuViewController new];
    menuList.sortModel = self.MenuSort_arr[indexPath.row];
    
    //创建核心动画
    CATransition *ca=[CATransition animation];
    //告诉要执行什么动画
    //设置过度效果
    ca.type=@"cube";
    //设置动画的过度方向（向右）
    ca.subtype=kCATransitionFromRight;
    //设置动画的时间
    ca.duration=1.0;
    [self.navigationController.view.layer addAnimation:ca forKey:nil];
    [self.navigationController pushViewController:menuList animated:YES];
    
}


@end
