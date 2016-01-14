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
    
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:topView];
    
    JXIconTextField *nameField = [[JXIconTextField alloc] init];
    nameField.placeholder = @"请输入用户名";
    [nameField setEditingImage:[UIImage imageNamed:@"login_name_high"] endEditImage:[UIImage imageNamed:@"login_name"]];
    [self.view addSubview:nameField];
    self.nameField = nameField;
    
    JXIconTextField *pwdField = [[JXIconTextField alloc] init];
    pwdField.placeholder = @"请输入密码";
    [pwdField setEditingImage:[UIImage imageNamed:@"login_pwd_high"] endEditImage:[UIImage imageNamed:@"login_pwd"]];
    [self.view addSubview:pwdField];
    self.pwdField = pwdField;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = fieldH * 0.5;
    loginBtn.backgroundColor = JXColor(252, 125, 29);
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    UIButton *forgotPwdBtn = [[UIButton alloc] init];
    [forgotPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgotPwdBtn setTitleColor:JXColor(182, 182, 182) forState:UIControlStateNormal];
    [self.view addSubview:forgotPwdBtn];
    
    UIButton *noAccountBtn = [[UIButton alloc] init];
    [noAccountBtn setTitle:@"还没有账号?" forState:UIControlStateNormal];
    [noAccountBtn setTitleColor:JXColor(182, 182, 182) forState:UIControlStateNormal];
    // 监听注册按钮点击
    [noAccountBtn addTarget:self action:@selector(noAccountBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noAccountBtn];
    
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

- (void)noAccountBtnClicked {
    JXRegisterViewController *registerVC = [[JXRegisterViewController alloc] init];
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:registerVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
