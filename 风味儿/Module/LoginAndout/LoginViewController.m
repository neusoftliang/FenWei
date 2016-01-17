//
//  LoginViewController.m
//  风味儿
//
//  Created by neusoftliang on 16/1/15.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "LoginViewController.h"
#import "IMTools.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName_textField;
@property (weak, nonatomic) IBOutlet UITextField *password_textField;
@property (assign,nonatomic) BOOL loginStatus;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (IBAction)returnLeftMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerFunc:(id)sender
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
    [IMTools registerManagerByUserName:self.userName_textField.text AnduserPasswd:self.password_textField.text returnBlock:^(BOOL isSuccess, EMError *error) {
        NSLog(@"%d",isSuccess);
        if (!error) {
            hud.labelText = @"注册成功";
        }else
        {
            switch (error.errorCode) {
                case EMErrorServerDuplicatedAccount:
                    hud.labelText = @"用户名已经存在";
                    break;
                case EMErrorInvalidUsername:
                    hud.labelText = @"用户名为数字、字母、或下划线组合";
                    break;
                default:
                     hud.labelText = @"注册失败！";
                    break;
            }
        }
    }];
}
- (IBAction)loginFunc:(id)sender
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
    if (self.userName_textField.text.length!=0||self.password_textField.text.length!=0) {
         [IMTools loginManagerByUserName:self.userName_textField.text AnduserPasswd:self.password_textField.text returnBlock:^(NSDictionary *userInfo, EMError *error) {
             NSLog(@"userInfo%@",userInfo);
             NSLog(@"errorInfo%@",error);
             if (!error) {
                 hud.labelText = @"登录成功";
                 self.loginStatus = YES;
                 [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                 
                 // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
                 [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
                 //获取数据库中数据
                 [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                 
                 //获取群组列表
                 [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
                 
                 //发送自动登陆状态通知
                 [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_userName_textField.text password:_password_textField.text completion:^(NSDictionary *loginInfo, EMError *error) {
                     if (!error) {
                         // 设置自动登录
                         [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                     }
                 } onQueue:nil];
                 [self saveUserInfoBy:userInfo];
                 [self returnLeftMenu:nil];
             }else
             {
                 switch (error.errorCode) {
                     case EMErrorNotFound:
                         hud.labelText = @"请注册后重新登录";
                         break;
                     case EMErrorServerAuthenticationFailure:
                         hud.labelText = @"用户名或密码错误，请重新登录";
                     default:
                         hud.labelText = @"登录失败";
                         break;
                 }
             }
         }];
    }
    else
    {
        hud.labelText = @"请输入用户名或密码！";
    }
    
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

/**
 *  将成功登录后的用户信息存储到NSUserDefault文件中
 */
-(void) saveUserInfoBy:(NSDictionary *)userInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [dic setValue:[NSNumber numberWithBool:self.loginStatus] forKey:@"loginFlag"];
    [user setObject:dic forKey:@"userInfo"];
}
@end
