//
//  ClockTableViewCell.h
//  风味儿
//
//  Created by neusoftliang on 16/1/12.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UILabel *timer_label;
@property (weak, nonatomic) IBOutlet UISwitch *timer_swithch;
@property (strong,nonatomic) NSDictionary *dic;
@end
