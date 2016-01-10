//
//  MaterialMenuViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/10.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MaterialMenuViewController.h"
#import "MaterialMenuCell.h"
@interface MaterialMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *foodImage_imgView;
@property (weak, nonatomic) IBOutlet UILabel *foodName_label;
@property (weak, nonatomic) IBOutlet UILabel *foodMate_label;
@property (weak, nonatomic) IBOutlet UIButton *pluse_button;
@property (weak, nonatomic) IBOutlet UITableView *MaterialListTableView;
@property (weak, nonatomic) IBOutlet UITextField *unit_textField;
@property (weak, nonatomic) IBOutlet UIButton *addNum_button;
@property (weak, nonatomic) IBOutlet UITextField *inputMaterial_textField;
@property (weak, nonatomic) IBOutlet UITextField *num_textField;
@property (weak, nonatomic) IBOutlet UIButton *addInMenu_button;

@property (strong,nonatomic) NSMutableArray *materials_mutArray;
@end

@implementation MaterialMenuViewController
- (NSMutableArray *)materials_mutArray {
    if(_materials_mutArray == nil) {
        _materials_mutArray = [NSMutableArray array];
    }
    return _materials_mutArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMenuHeader];
    [self configMenuAddFunc];
    [self configMaterialsMenu];
    [self getMaterialsFromDB];
}
#pragma mark --- 配置清单头
/**
 *  配置清单的首视图
 */
-(void)configMenuHeader
{
    self.foodMate_label.text = self.des.food;
    self.foodName_label.text = self.des.name;
    [self.foodImage_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImagePath,self.des.img]] placeholderImage:[UIImage imageNamed:@"placeImage"]];
}
#pragma mark --- 配置添加食材功能
/**
 *  配置添加食材功能
 */
-(void)configMenuAddFunc
{
    __block int num = 0;
    __block int materialID = self.des.id;
    num = [self.num_textField.text intValue];
    __weak typeof(self) weakSelf = self;
    [self.pluse_button bk_addEventHandler:^(id sender) {
        num++;
        weakSelf.num_textField.text = [NSString stringWithFormat:@"%d",num];
        [weakSelf.num_textField layoutIfNeeded];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.addNum_button bk_addEventHandler:^(id sender) {
        
        if (num>0) {
            num--;
        }
        weakSelf.num_textField.text = [NSString stringWithFormat:@"%d",num];
        [weakSelf.num_textField layoutIfNeeded];
    } forControlEvents:UIControlEventTouchUpInside];
    
//    if (![self.inputMaterial_textField.text isEqualToString:@""]) {
        [self.addInMenu_button bk_addEventHandler:^(id sender) {
            
            FoodMaterialsModel *foodMaterial = [FoodMaterialsModel new];
            foodMaterial.food_ID = self.des.id;
            foodMaterial.materialName = self.inputMaterial_textField.text;
            foodMaterial.materialNum = [self.num_textField.text integerValue];
            foodMaterial.materialUnit = self.unit_textField.text;
            materialID = materialID+1;
            foodMaterial.material_ID = materialID;
            [DatabaseManager openDatabase:^(FMDatabase *db, BOOL isSuccess) {
                BOOL success = [DatabaseManager excuteDatabase:db SQL:nil By:foodMaterial FuncSelect:INSERTDATA];
                NSLog(@"插入食材状态%d",success);
                [self getMaterialsFromDB];
                [DatabaseManager closeDatabase:db];
            }];
        } forControlEvents:UIControlEventTouchUpInside];
//    }
}

#pragma mark --- 配置食材展示列表
/**
 *  配置食材展示列表
 */
-(void)configMaterialsMenu
{
    self.MaterialListTableView.delegate = self;
    self.MaterialListTableView.dataSource = self;
    [self.MaterialListTableView registerNib:[UINib nibWithNibName:@"MaterialMenuCell" bundle:nil] forCellReuseIdentifier:@"material"];
}
#pragma mark ------UITableView协议的实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.materials_mutArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaterialMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"material" forIndexPath:indexPath];
    FoodMaterialsModel *material = self.materials_mutArray[indexPath.row];
    cell.materialName_label.text = material.materialName;
    cell.materialNum_label.text = [NSString stringWithFormat:@"%ld",material.materialNum];
    cell.materialUnit_label.text = material.materialUnit;
    return cell;
}
#pragma mark --- 从数据库中取得食材数据
/**
 *  从数据库中取得食材数据
 */
-(void)getMaterialsFromDB
{
    [self.materials_mutArray removeAllObjects];
    [DatabaseManager openDatabase:^(FMDatabase *db, BOOL isSuccess) {
        if (isSuccess) {
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE foodID='%ld'",kTableName_Material,self.des.id];
            FMResultSet *result = [db executeQuery:sql];
            while ([result next])
            {
                FoodMaterialsModel *foodModel = [FoodMaterialsModel new];
                foodModel.materialName = [result stringForColumn:kt_foodMaterials_materialName];
                foodModel.materialNum = [result intForColumn:kt_foodMaterials_materialNum];
                foodModel.materialUnit = [result stringForColumn:kt_foodMaterials_materialUnit];
                [self.materials_mutArray addObject:foodModel];
            }
            [self.MaterialListTableView reloadData];
        }
        [DatabaseManager closeDatabase:db];
    }];
    
}
@end
