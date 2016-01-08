//
//  MenuSearchNetManager.h
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NetManager.h"
#import "MenuSearchModel.h"
@interface MenuSearchNetManager : NetManager
+(id)getMenuDescBySearchName:(NSString *)menuName kCompletionHandle;
@end
