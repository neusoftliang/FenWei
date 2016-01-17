//
//  ConversationListViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/17.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "ConversationListViewController.h"
#import "EaseConversationModel.h"
#import "MessageViewController.h"
#import "EaseConversationCell.h"
#import "EMConversation.h"
@interface ConversationListViewController ()<EaseConversationListViewControllerDelegate,EaseConversationListViewControllerDataSource>

@end

@implementation ConversationListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource=  self;
    self.delegate = self;
}

//最后一条消息展示内容样例
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    //用户获取最后一条message,根据message的messageBodyType展示显示最后一条message对应的文案
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case eMessageBodyType_File: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    return latestMessageTitle;
}

//最后一条消息展示时间样例
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    //用户获取最后一条message,根据lastMessage中timestamp,自定义时间文案显示(例如:"1分钟前","14:20")
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    return latestMessageTime;
}

-(id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *ICmodel = [[EaseConversationModel alloc]initWithConversation:(EMConversation *)conversation];
    return ICmodel;
}
//会话列表点击的回调样例
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    //样例展示为根据conversationModel,进入不同的会话ViewController
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
            MessageViewController *chatController = [[MessageViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
            chatController.title = conversationModel.title;
            [self.navigationController pushViewController:chatController animated:YES];
        }
    }
}



@end
