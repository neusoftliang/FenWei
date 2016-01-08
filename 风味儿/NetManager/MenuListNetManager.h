//
//  MenuListNetManager.h
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NetManager.h"
#import "MenuListModel.h"
@interface MenuListNetManager : NetManager
+(id)getMenuListBySortID:(NSInteger)sort_id AndPage:(NSInteger)page kCompletionHandle;
@end
