//
//  DatabaseManager.m
//  风味儿
//
//  Created by neusoftliang on 16/1/9.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "DatabaseManager.h"
#import "MenuDescModel.h"
#import "FoodMaterialsModel.h"
@implementation DatabaseManager
+(void)openDatabase:(void (^)(FMDatabase *, BOOL))openBlock
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"cartDB.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL dbisSucess = [db open];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dbisSucess) {
            NSString *sqlCreateTable1 =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' TEXT ,'%@' INTEGER)",
                                        kTableName_Food,kt_food_foodID,kt_food_foodName,kt_food_foodImg,kt_food_foodMaterial,kt_food_foodinsertDate];
            BOOL res = [db executeUpdate:sqlCreateTable1];
            
            NSString *sqlCreateTable2 =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' INTEGER, '%@' TEXT, '%@' INTEGER ,'%@' TEXT)",kTableName_Material,kt_foodMaterials_foodID,kt_foodMaterials_materialID,
                kt_foodMaterials_materialName,
                kt_foodMaterials_materialNum,
                kt_foodMaterials_materialUnit];
            BOOL res1 = [db executeUpdate:sqlCreateTable2];

            if (!res) {
                NSLog(@"error when creating db table");
            } else {
                NSLog(@"success to creating db table");
            }
            if (!res1) {
                NSLog(@"1error when creating db table");
            } else {
                NSLog(@"1success to creating db table");
            }
        }
    });
    openBlock(db,dbisSucess);
}
+(BOOL)excuteDatabase:(FMDatabase *)db By:(id)data FuncSelect:(dbHandle)handle
{
    
    if ([db open])
    {
        switch (handle)
        {
            case INSERTDATA:
            {
                if ([data isKindOfClass:[MenuDescModel class]]) {
                    MenuDescModel *foodDesc = (MenuDescModel *)data;
                    NSString *insertSql1= [NSString stringWithFormat:
                                           @"INSERT INTO '%@' ('%@', '%@', '%@' , '%@', '%@') VALUES ('%ld', '%@', '%@', '%@', '%f')",
                                           kTableName_Food,
                                           kt_food_foodID,kt_food_foodName,kt_food_foodImg,kt_food_foodMaterial,kt_food_foodinsertDate,foodDesc.id , foodDesc.name,foodDesc.img,foodDesc.food, [[NSDate date] timeIntervalSince1970]];
                    return [db executeUpdate:insertSql1];
                }
               else if([data isKindOfClass:[FoodMaterialsModel class]])
               {
                   FoodMaterialsModel *foodMaterial = (FoodMaterialsModel *)data;
                   for (Materials *materials in foodMaterial.materials) {
                       NSString *insertSql1= [NSString stringWithFormat:
                                              @"INSERT INTO '%@' ('%@', '%@', '%@' , '%@', '%@') VALUES ('%ld', '%ld', '%@', '%ld', '%@')",
                                              kTableName_Material,
                                              kt_foodMaterials_foodID,
                                              kt_foodMaterials_materialID,
                                              kt_foodMaterials_materialName,
                                              kt_foodMaterials_materialNum,
                                              kt_foodMaterials_materialUnit,foodMaterial.food_ID ,materials.material_ID ,materials.materialName,materials.materialNum, materials.materialUnit];
                       if (![db executeUpdate:insertSql1])
                       {
                           return NO;
                       }
                       
                   }
                   return YES;
                   
               }else
               {
                   return NO;
               }
                
            }
                break;
            case DELETEDATA:
                return YES;
                break;
            case UPDATEDATA:
                return YES;
                break;
            case SELECTDATA:
                return YES;
                break;
            default:
                return YES;
                break;
        }
    }
    else
        return NO;
}
+(void)closeDatabase:(FMDatabase *)db
{
    [db close];
}
@end
