//
//  JXLoginViewController.m
//  JMXMiJia
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXLoginViewController.h"
#import <Masonry.h>
#import "JXIconTextField.h"
#import "JXRegisterViewController.h"
#import "JXNavigationController.h"
#import <SVProgressHUD.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import "JXAccount.h"
#import "JXTabBarController.h"
#import "JXForgotPwdController.h"

@interface JXLoginViewController ()

@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic, weak) UITextField *pwdField;
@property (nonatomic, weak) UIButton *loginBtn;
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation JXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat margin = 20;
    CGFloat fieldH = 35;
    
    // 设置背景
    [self setupTopView];
    
    UIImageView *backView = [[UIImageView alloc] init];
    
    backView.image = [UIImage imageNamed:@"login_bg.jpg"];
    [self.view addSubview:backView];
    
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:topView];
    
    JXIconTextField *nameField = [[JXIconTextField alloc] init];
    nameField.placeholder = @"请输入用户名";
    [nameField setEditingImage:[UIImage imageNamed:@"login_name_high"] endEditImage:[UIImage imageNamed:@"login_name"]];
    [self.view addSubview:nameField];
    self.nameField = nameField;
    
    JXIconTextField *pwdField = [[JXIconTextField alloc] init];
    pwdField.secureTextEntry = YES;
    pwdField.placeholder = @"请输入密码";
    [pwdField setEditingImage:[UIImage imageNamed:@"login_pwd_high"] endEditImage:[UIImage imageNamed:@"login_pwd"]];
    [self.view addSubview:pwdField];
    self.pwdField = pwdField;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = fieldH * 0.5;
    loginBtn.backgroundColor = JXColor(252, 125, 29);
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    UIButton *forgotPwdBtn = [[UIButton alloc] init];
    [forgotPwdBtn addTarget:self action:@selector(forgotPwdBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [forgotPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgotPwdBtn setTitleColor:JXColor(182, 182, 182) forState:UIControlStateNormal];
    [self.view addSubview:forgotPwdBtn];
    
    UIButton *noAccountBtn = [[UIButton alloc] init];
    [noAccountBtn setTitle:@"还没有账号?" forState:UIControlStateNormal];
    [noAccountBtn setTitleColor:JXColor(182, 182, 182) forState:UIControlStateNormal];
    // 监听注册按钮点击
    [noAccountBtn addTarget:self action:@selector(noAccountBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noAccountBtn];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.equalTo(self.view.centerY).offset(-margin);

    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(self.view.centerY).offset(-margin);
        make.width.equalTo(self.view.width).multipliedBy(0.8).offset(0);
        make.height.equalTo(topView.width).multipliedBy(0.628);
    }];
    
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.centerY).offset(margin);
        make.centerX.offset(0);
        make.width.equalTo(self.view.width).multipliedBy(0.8).offset(0);
        make.height.offset(fieldH);
    }];
    
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nameField);
        make.top.equalTo(nameField.bottom).offset(margin);
        make.width.equalTo(nameField);
        make.height.offset(fieldH);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nameField);
        make.top.equalTo(pwdField.bottom).offset(margin * 2);
        make.width.equalTo(nameField);
        make.height.offset(fieldH);
    }];
    
    [forgotPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.bottom).offset(margin);
        make.right.equalTo(loginBtn.centerX).offset(-margin);
    }];
    
    [noAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.bottom).offset(margin);
        make.left.equalTo(loginBtn.centerX).offset(margin);
    }];
}

/**
 *  设置背景
 */
- (void)setupTopView {
    
}

/**
 *  登录按钮被点击
 */
- (void)loginBtnClicked {
    if (self.nameField.text.length == 0 || self.pwdField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写账号和密码" maskType:SVProgressHUDMaskTypeBlack];
    }
    else {
        [SVProgressHUD showWithStatus:@"正在登录"];
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"mobile"] = self.nameField.text;
        // md5加密
        paras[@"password"] = self.pwdField.text;
        paras[@"pushToken"] = [JXAccountTool account].pushToken;
        
        [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/Login" params:paras success:^(id json) {
            BOOL success = [json[@"success"] boolValue];
            JXLog(@"json = %@", json);
            if (success == 0) { // 登录失败
                [SVProgressHUD showErrorWithStatus:json[@"msg"]];
            }
            else { // 登录成功
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                // 存入账号密码
                JXAccount *account = [JXAccountTool account];
                account.mobile = json[@"mobile"];
                account.password = paras[@"password"];
                [JXAccountTool saveAccount:account];
                
                // 请求用户信息
                [self getAccountInfomationWithMobile:paras[@"mobile"] password:paras[@"password"]];
                
                // 进入app主页
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                JXLog(@"keywindow = %@", window);
                window.rootViewController = [[JXTabBarController alloc] init];
            }
        } failure:^(NSError *error) {
            JXLog(@"请求失败 - %@", error);
            [SVProgressHUD showErrorWithStatus:@"请求网络失败"];
        }];
    }
}

/**
 *  请求用户信息
 */
- (void)getAccountInfomationWithMobile:(NSString *)mobile password:(NSString *)password {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"mobile"] = mobile;
    paras[@"password"] = password;
    [JXHttpTool post:[NSString stringWithFormat:@"%@/TraineeInfo", JXServerName] params:paras success:^(id json) {
        JXLog(@"json = %@", json);
        BOOL success = json[@"success"];
        if (success) {
            // 将个人信息存入沙盒
            JXAccount *account = [JXAccountTool account];
            account.name = json[@"name"];
            account.mobile = json[@"mobile"];
            account.count = [json[@"count"] integerValue];
            account.photo = [NSString stringWithFormat:@"%@/%@", JXServerName, json[@"photo"]];
            account.balance = [json[@"balance"] floatValue];
            // 存储登录状态
            account.hasLogin = YES;
            [JXAccountTool saveAccount:account];
        }
    } failure:^(NSError *error) {
        JXLog(@"请求失败-%@", error);
    }];
}

- (void)forgotPwdBtnClicked {
    JXForgotPwdController *forgotVC = [[JXForgotPwdController alloc] init];
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:forgotVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)noAccountBtnClicked {
    JXRegisterViewController *registerVC = [[JXRegisterViewController alloc] init];
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:registerVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
