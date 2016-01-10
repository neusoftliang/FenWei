//
//  MaterialCartViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/9.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MaterialCartViewController.h"
#import "TableViewCell.h"
#import "MenuDescModel.h"
#import "MaterialMenuViewController.h"
@interface MaterialCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)NSMutableArray *menuList_mutArry;
@property (strong,nonatomic) UITableView *listTableView;
@end

@implementation MaterialCartViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"menu"]) {
        NSIndexPath *indexPath = sender;
        MaterialMenuViewController *menu = segue.destinationViewController;
        menu.des = self.menuList_mutArry[indexPath.row];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMaterialList];
}
/**
 *  配置tableView
 */
-(void)configMaterialList
{
    UITableView *listTableView = [[UITableView alloc]init];
    self.listTableView = listTableView;
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [listTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"food"];
    [self.view addSubview:listTableView];
    [listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
#pragma mark --- UITableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuList_mutArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"food"];
    MenuDescModel *des = self.menuList_mutArry[indexPath.row];
    [cell.foodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImagePath,des.img]] placeholderImage:[UIImage imageNamed:@"placeImage"]];
    cell.foodName.text = des.name;
    cell.foodDesc.text = des.food;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"menu" sender:indexPath];
}
/**
 *  从数据库中获取加入购菜蓝的数据
 */
-(void)getDataFromDB
{
    [DatabaseManager openDatabase:^(FMDatabase *db, BOOL isSuccess) {
        if ([db open]) {
            NSLog(@"open");
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@",kTableName_Food];
            FMResultSet * rs = [db executeQuery:sql];
            while ([rs next]) {
                MenuDescModel *desc = [MenuDescModel new];
                desc.id = [rs intForColumn:kt_food_foodID];
                desc.img = [rs stringForColumn:kt_food_foodImg];
                desc.name = [rs stringForColumn:kt_food_foodName];
                desc.food = [rs stringForColumn:kt_food_foodMaterial];
                desc.count = [rs intForColumn:kt_food_foodinsertDate];
                NSLog(@"count%ld",desc.count);
                [self.menuList_mutArry addObject:desc];
            }
            [self.listTableView reloadData];
            [db close];
        }
    }];
}
- (NSMutableArray *)menuList_mutArry {
	if(_menuList_mutArry == nil) {
		_menuList_mutArry = [NSMutableArray array];
	}
	return _menuList_mutArry;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.menuList_mutArry removeAllObjects];
    [self getDataFromDB];
}
@end
