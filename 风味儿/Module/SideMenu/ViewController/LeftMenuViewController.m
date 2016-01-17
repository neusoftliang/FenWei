//
//  LeftMenuViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/15.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LoginViewController.h"
@interface LeftMenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *user_photo;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_nickName;
@property (assign,nonatomic) BOOL loginStatus;
@property (weak,nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LeftMenuViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [user valueForKey:@"userInfo"];
    if ([userInfo[@"loginFlag"] boolValue]==YES)
    {
        self.loginStatus = YES;
        [self.loginBtn setTitle:@"取消登录" forState:UIControlStateNormal];
        
    }else
    {
        self.loginStatus = NO;
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.user_photo.layer.masksToBounds = YES;
    self.user_photo.layer.cornerRadius = 50;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginFunc:(UIButton *)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfo =[NSMutableDictionary dictionaryWithDictionary:[user valueForKey:@"userInfo"]];
    
    if (self.loginStatus)
    {
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES/NO completion:^(NSDictionary *info, EMError *error) {
             NSLog(@"......error%@,info%@",error,info);
            if (!error && !info) {
                NSLog(@"......");
                [userInfo setObject:[NSNumber numberWithBool:NO] forKey:@"loginFlag"];
                NSLog(@"dictionary%@",userInfo);
                [user setObject:userInfo forKey:@"userInfo"];
                self.loginStatus = NO;
                [user synchronize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
                    [self.view layoutIfNeeded];
                });
                
            }
        } onQueue:nil];
        
    }
    if (self.loginStatus==NO)
    {
        LoginViewController *loginVC = [LoginViewController new];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}
@end
