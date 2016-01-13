//
//  AddTimerViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/12.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "AddTimerViewController.h"

@interface AddTimerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *timerContent_textField;
@property (weak, nonatomic) IBOutlet UILabel *timeshow_label;
@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *minuPicker;
@property (strong,nonatomic) NSArray *hourData;
@property (strong,nonatomic) NSArray *minute;
@property (strong,nonatomic) NSTimer *timer;
@property (assign,nonatomic) int hours;
@property (assign,nonatomic) int minutes;
@end

@implementation AddTimerViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];//开启定时器
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configPickerView];
    self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        [self configTimeShow];
    } repeats:YES];
}

-(void)configTimeShow
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    self.timeshow_label.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, second];
    
}

-(void)configPickerView
{
    self.hourPicker.delegate = self;
    self.hourPicker.dataSource = self;
    self.minuPicker.delegate = self;
    self.minuPicker.dataSource = self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.timerContent_textField resignFirstResponder];
}
#pragma mark --- UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag==101) {
        return self.hourData.count;
    }
    else
        return self.minute.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag ==101) {
        return [NSString stringWithFormat:@"%@小时",self.hourData[row]];
    }else
        return [NSString stringWithFormat:@"%@分钟",self.minute[row]];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==101) {
        self.hours = [self.hourData[row] intValue];
    }else
        self.minutes = [self.minute[row] intValue];
}

- (IBAction)Cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addTimer:(id)sender
{
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *timeListPath = [documentPaht stringByAppendingPathComponent:@"timeList.plist"];
    NSMutableArray *mutableArry = [NSMutableArray arrayWithArray:[[NSArray alloc] initWithContentsOfFile:timeListPath]];
    
    NSString *desc = [NSString stringWithFormat:@"%@",self.timerContent_textField.text];
    double interval = [[NSDate date] timeIntervalSince1970];
    NSLog(@"interval%lf",interval);
    NSDictionary *dic = @{@"desc":desc,@"hours":[NSNumber numberWithInt:self.hours],@"minutes":[NSNumber numberWithInt:self.minutes],@"currentDate":[NSNumber numberWithDouble:interval]};
    [mutableArry addObject:dic] ;
    NSLog(@"写入状态%d", [mutableArry writeToFile:timeListPath atomically:YES]);
    [self Cancel:nil];
}
- (NSArray *)hourData {
	if(_hourData == nil) {
		_hourData = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23];
	}
	return _hourData;
}

- (NSArray *)minute {
	if(_minute == nil) {
		_minute = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,@26,@27,@28,@29,@30,@31,@32,@33,@34,@35,@36,@37,@38,@39,@40,@41,@42,@43,@44,@45,@46,@47,@48,@49,@50,@51,@52,@53,@54,@55,@56,@57,@58,@59];
	}
	return _minute;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    [_timer setFireDate:[NSDate distantFuture]];//停止定时器
}
@end
