//
//  JXForgotPwdController.m
//  JMXMiJia
//
//  Created by mac on 16/1/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXForgotPwdController.h"
#import "JXIconTextField.h"
#import <Masonry.h>
#import "MBProgressHUD+MJ.h"
#import <AFNetworking.h>

@interface JXForgotPwdController ()
/** 用户名 */
@property (nonatomic, weak) JXIconTextField *usernameField;
/** 重设密码 */
@property (nonatomic, weak) JXIconTextField *pwdField;
/** 验证码 */
@property (nonatomic, weak) JXIconTextField *verifyField;
/** 发送验证码按钮 */
@property (nonatomic, weak) UIButton *sendMsgButton;
/** 重设并登录按钮 */
@property (nonatomic, weak) UIButton *resetButton;
@end

@implementation JXForgotPwdController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat margin = 10; // field之间的间距
    CGFloat fieldH = 40; // field的高度
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    
    self.usernameField = [self setupTextFieldWithEditingImage:@"login_name_high" endEditImage:@"login_name" placeholder:@"请输入登录名(手机号)"];
    
    self.pwdField = [self setupTextFieldWithEditingImage:@"login_pwd_high" endEditImage:@"login_pwd" placeholder:@"请重新设置密码"];
    [self.pwdField setSecureTextEntry:YES];
    
    self.verifyField = [self setupTextFieldWithEditingImage:@"register_phone_high" endEditImage:@"register_phone" placeholder:@"请输入短信验证码"];
    
    UIButton *sendMsgButton = [[UIButton alloc] init];
    sendMsgButton.layer.cornerRadius = fieldH * 0.5;
    [sendMsgButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendMsgButton.backgroundColor = JXColor(170, 170, 0);
    // 监听按钮点击
    [sendMsgButton addTarget:self action:@selector(sendMsgButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMsgButton];
    self.sendMsgButton = sendMsgButton;
    
    UIButton *resetButton = [[UIButton alloc] init];
    resetButton.layer.cornerRadius = fieldH * 0.5;
    [resetButton setTitle:@"设置并登录" forState:UIControlStateNormal];
    resetButton.backgroundColor = JXColor(254, 125, 0);
    // 监听按钮点击
    [resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    self.resetButton = resetButton;
    
    [@[self.usernameField, self.pwdField, self.verifyField, self.sendMsgButton, self.resetButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.width.equalTo(self.view.width).multipliedBy(0.8);
        make.height.offset(fieldH);
    }];
    
    [self.usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64 + margin*2);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameField.bottom).offset(margin);
    }];
    
    [self.verifyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdField.bottom).offset(margin);
    }];
    
    [self.sendMsgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyField.bottom).offset(2 * margin);
    }];
    
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sendMsgButton.bottom).offset(margin);
    }];
}

- (JXIconTextField *)setupTextFieldWithEditingImage:(NSString *)editingImage endEditImage:(NSString *)endEditImage placeholder:(NSString *)placeholder {
    JXIconTextField *textField = [[JXIconTextField alloc] init];
    [textField setEditingImage:[UIImage imageNamed:editingImage] endEditImage:[UIImage imageNamed:endEditImage]];
    textField.placeholder = placeholder;
    [self.view addSubview:textField];
    
    return textField;
}

/**
 *  点击了导航栏上的取消按钮
 */
- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendMsgButtonClicked {
    if (self.usernameField.text.length == 0) {
        [MBProgressHUD showError:@"请填写手机号"];
    }
    else {
        // 发送请求
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"mobile"] = self.usernameField.text;
        [mgr POST:@"http://10.255.1.24/dschoolAndroid/SendCheckCode" parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            JXLog(@"成功 - %@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            JXLog(@"失败 - %@", error);
        }];
    }
}

- (void)resetButtonClicked {
    
}
@end
