//
//  JXStudentProfileController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXStudentProfileController.h"
#import "JXProfileHeaderView.h"
#import "JXProfileMoneyCell.h"
#import "JXProfileInfoController.h"
#import <UIImageView+WebCache.h>
#import "JXAccount.h"
#import "JXAccountTool.h"
#import "JXLoginViewController.h"
#import "AppDelegate.h"

@interface JXStudentProfileController () <UITableViewDataSource, UITableViewDelegate, JXProfileHeaderViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation JXStudentProfileController

static NSString * const ID = @"profileCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人";
    
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 3;
            break;
            
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}

#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        JXProfileMoneyCell *moneyCell = [JXProfileMoneyCell moneyCell];
        JXAccount *account = [JXAccountTool account];
        moneyCell.account = account;
        return moneyCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // 设置数据
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"profile_pay"];
                cell.textLabel.text = @"支付状态";
                break;
                
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"profile_firend"];
                cell.textLabel.text = @"我的好友";
                break;
                
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"profile_welcome"];
                cell.textLabel.text = @"欢迎页";
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"profile_setting"];
                cell.textLabel.text = @"注销";
                break;
                
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"profile_help"];
                cell.textLabel.text = @"帮助";
                break;
                
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) { // 注销
        // 提示是否注销
        if (iOS8) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定注销?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:cancleAction];
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 清空account登录状态
                JXAccount *account = [JXAccountTool account];
                account.hasLogin = NO;
                [JXAccountTool saveAccount:account];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = [[JXLoginViewController alloc] init];
            }];
            [alertVC addAction:confirmAction];
            
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        else {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定注销?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
            [actionSheet showFromTabBar:self.tabBarController.tabBar];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        JXProfileHeaderView *header = [[JXProfileHeaderView alloc] init];
        header.account = [JXAccountTool account];
        header.delegate = self;
        return header;
    }
    else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 100;
    }
    else return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    else return 64;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 确定
        // 清空account登录状态
        JXAccount *account = [JXAccountTool account];
        account.hasLogin = NO;
        [JXAccountTool saveAccount:account];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[JXLoginViewController alloc] init];
    }
}

#pragma mark - JXProfileHeaderViewDelegate
- (void)profileHeaderViewDidClickedProfileInfoButton {
    JXProfileInfoController *profileInfoVC = [[JXProfileInfoController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:profileInfoVC animated:YES];
}
@end
