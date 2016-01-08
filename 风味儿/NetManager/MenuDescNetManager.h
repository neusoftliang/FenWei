//
//  MenuDescNetManager.h
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NetManager.h"
#import "MenuDescModel.h"
@interface MenuDescNetManager : NetManager
+(id)getMenuDescByListID:(NSInteger)list_id kCompletionHandle;
@end
