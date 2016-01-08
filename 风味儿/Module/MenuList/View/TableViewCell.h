//
//  TableViewCell.h
//  风味儿
//
//  Created by neusoftliang on 16/1/7.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodDesc;
@end
