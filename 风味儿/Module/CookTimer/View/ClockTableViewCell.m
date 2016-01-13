//
//  ClockTableViewCell.m
//  风味儿
//
//  Created by neusoftliang on 16/1/12.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "ClockTableViewCell.h"
@interface ClockTableViewCell()
@property (assign,nonatomic) int num;
@end
@implementation ClockTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)TimerSwitch:(UISwitch *)sender
{
    UILocalNotification *timerNotif = [[UILocalNotification alloc]init];
    NSNumber *numHour = self.dic[@"hours"];
    NSNumber *numMinute = self.dic[@"minutes"];
    int interval = numHour.intValue*3600+numMinute.intValue*60;
    if (sender.isOn)
    {
        NSDate *now = [NSDate new];
        timerNotif.fireDate = [now dateByAddingTimeInterval:interval];
        NSLog(@"notif%@",timerNotif.fireDate);
        
        timerNotif.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        timerNotif.timeZone=[NSTimeZone defaultTimeZone];
        
        //timerNotif.applicationIconBadgeNumber= _num++; //应用的红色数字
        
        timerNotif.soundName= @"bg.caf";//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        timerNotif.alertBody=self.dic[@"desc"];//提示信息 弹出提示框
        timerNotif.alertAction = @"打开";  //提示框按钮
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
//        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"notification_name" forKey:@""];
//        
//        notification.userInfo = infoDict; //添加额外的信息
        [[UIApplication sharedApplication] scheduleLocalNotification:timerNotif];
    }
    NSLog(@"switch.tag%ld",sender.tag);
    NSLog(@"dic%@",self.dic);
}

@end
