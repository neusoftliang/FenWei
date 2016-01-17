//
//  MessageViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/17.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showRefreshHeader = YES;
    self.dataSource=  self;
    self.delegate = self;

    //通过会话管理者获取已收发消息
    [self tableViewDidTriggerHeaderRefresh];
    
    EaseEmotionManager *manager= [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:[EaseEmoji allEmoji]];
    [self.faceView setEmotionManagers:@[manager]];
}
@end
