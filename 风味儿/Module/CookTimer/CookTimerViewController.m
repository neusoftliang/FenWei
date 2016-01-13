//
//  CookTimerViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/11.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "CookTimerViewController.h"
#import "BEMAnalogClockView.h"
#import "ClockTableViewCell.h"
#import "AddTimerViewController.h"
@interface CookTimerViewController ()<UITableViewDelegate,UITableViewDataSource,BEMAnalogClockDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerBgView;
@property (weak, nonatomic) IBOutlet UIView *settingBgView;

@property (weak, nonatomic) IBOutlet UIView *timeShowView;
@property (weak, nonatomic) IBOutlet UITableView *timeListTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeListTabHight_constraint;
@property (strong,nonatomic) BEMAnalogClockView *clock;
@property (strong,nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (strong,nonatomic) UISwipeGestureRecognizer *swipUp;
@property (strong,nonatomic) UISwipeGestureRecognizer *swipDown;
@property (assign,nonatomic) CGFloat originalOffset;

@property (strong,nonatomic) NSMutableArray *timeArray;
@end

@implementation CookTimerViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _clock.hidden = NO;
    [_time_label setAlpha:0];
    self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer)
    {
        [self configClock];
    } repeats:YES];
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *timeListPath = [documentPaht stringByAppendingPathComponent:@"timeList.plist"];
    _timeArray = [[NSMutableArray alloc] initWithContentsOfFile:timeListPath];
    [self.timeListTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configGestureRecognizer];
    self.timeListTableView.dataSource = self;
    self.timeListTableView.delegate = self;
    self.timeListTableView.scrollEnabled = NO;
}
/**
 *  配置时钟控件
 */
- (BEMAnalogClockView *)clock {
    if(_clock == nil) {
        _clock = [[BEMAnalogClockView alloc] init];
        _clock.currentTime = YES;
        _clock.enableDigit = YES;
        _clock.delegate = self;
        [self.headerBgView addSubview:_clock];
        [_clock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(100);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
    }
    return _clock;
}
-(void)configClock
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    _clock.hours = hour;
    _clock.minutes = minute; // Random value between 1 and 60
    _clock.seconds = second;// Random value between 1 and 60
    [self.clock updateTimeAnimated:YES];
}
- (void)currentTimeOnClock:(BEMAnalogClockView *)clock Hours:(NSString *)hours Minutes:(NSString *)minutes Seconds:(NSString *)seconds {
    
    int hoursInt = [hours intValue];
    int minutesInt = [minutes intValue];
    int secondsInt = [seconds intValue];
    self.time_label.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hoursInt, minutesInt, secondsInt];
    
}
/**
 *  配置轻扫手势
 */
-(void)configGestureRecognizer
{
    [self.view layoutIfNeeded];
    self.timeListTableView.delegate = self;
    CGFloat originalHeight = self.timeListTabHight_constraint.constant;
    CGFloat height =self.view.bounds.size.height-86-64-48;
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [UIView animateWithDuration:0.5 animations:^{
            self.timeListTabHight_constraint.constant = height;
            [self.clock setAlpha:0];
            [self.time_label setAlpha:1];
            [self.view layoutIfNeeded];
        }];
    } delay:0];
    swipUp.direction = UISwipeGestureRecognizerDirectionUp;
    self.swipUp = swipUp;
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [UIView animateWithDuration:0.5 animations:^{
            self.timeListTabHight_constraint.constant =originalHeight;
            [self.clock setAlpha:1];
            [self.time_label setAlpha:0];
            [self.view layoutIfNeeded];
        }];
    } delay:0];
    swipDown.direction = UISwipeGestureRecognizerDirectionDown;
    self.swipDown = swipDown;
    [self.view addGestureRecognizer:swipUp];
    [self.view addGestureRecognizer:swipDown];
}


#pragma mark ------UITableView Delegate/UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clock" forIndexPath:indexPath];
    cell.dic = self.timeArray[indexPath.row];
    cell.timer_label.text = [NSString stringWithFormat:@"%@小时%@分钟",self.timeArray[indexPath.row][@"hours"],self.timeArray[indexPath.row][@"minutes"]];
    cell.content_label.text = self.timeArray[indexPath.row][@"desc"];
    cell.timer_swithch.tag = indexPath.row;
    return cell;
}

/**
 *  编辑cell
 *
 */

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *timeListPath = [documentPaht stringByAppendingPathComponent:@"timeList.plist"];
        [self.timeArray removeObjectAtIndex:indexPath.row];
        if ([self.timeArray writeToFile:timeListPath atomically:YES]) {
            [tableView reloadData];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    [_timeArray removeAllObjects];
    _timeArray = nil;
}
/**
 *  添加定时项
 */
- (IBAction)addTimer:(id)sender {
    
    [self performSegueWithIdentifier:@"addTimer" sender:nil];
    
}
/**
 *  闹钟设置
 *
 */
- (IBAction)settingTimer:(id)sender {
    
    
}
@end
