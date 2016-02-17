//
//  JXTeacherDetailController.m
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherDetailController.h"
#import "JXTeacherDetailCell.h"
#import "JXTeacher.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "JXDetailHeaderView.h"
#import "JXDetailFooterView.h"
#import "JXFeeDetailController.h"
#import "JXNavigationController.h"
#import "JXSearchParas.h"
#import "JXFeeGroup.h"
#import "JXFee.h"
#import <MJExtension.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import "JXFeeGroupTool.h"
#import <SVProgressHUD.h>

@interface JXTeacherDetailController () <JXTeacherDetailCellDelegate, JXFeeDetailControllerDelegate>

@end

@implementation JXTeacherDetailController

#pragma mark - 懒加载
- (NSArray *)feeGroups {
    if (_feeGroups == nil) {
        _feeGroups = [JXFeeGroup mj_objectArrayWithFilename:@"feeGroup.plist"];
        
        JXFeeGroup *starGroup = _feeGroups[2];
        for (int i = 0; i < starGroup.fees.count; i ++) {
            if (self.teacher.star == starGroup.fees.count - 1 - i) {
                JXFee *starFee = starGroup.fees[i];
                starFee.copies = 1;
            }
        }
    }
    return _feeGroups;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"教练介绍";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JXTeacherDetailCell" bundle:nil] forCellReuseIdentifier:@"teacherDetail"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTeacherDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacherDetail" forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teacher = self.teacher;
    cell.feeGroups = self.feeGroups;
    cell.delegate = self;
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"teacherDetail" cacheByIndexPath:indexPath configuration:^(JXTeacherDetailCell *cell) {
        cell.teacher = self.teacher;
    }];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXDetailHeaderView *header = [JXDetailHeaderView headerView];
    header.teacher = self.teacher;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [JXDetailHeaderView headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    JXDetailFooterView *footer = [JXDetailFooterView footerView];
#warning 还没设置数据
    footer.signupButtonClickedAction = ^{
        // 报名按钮被点击，发送数据给服务器
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        JXAccount *account = [JXAccountTool account];
        paras[@"mobile"] = account.mobile;
        paras[@"password"] = account.password;
        paras[@"cid"] = self.teacher.uid;
        paras[@"aidItem"] = [JXFeeGroupTool aidItemWithFeeGroups:self.feeGroups];
        [JXHttpTool post:[NSString stringWithFormat:@"%@/Reservation", JXServerName] params:paras success:^(id json) {
            BOOL success = [json[@"success"] boolValue];
            if (success) {
                [SVProgressHUD showSuccessWithStatus:json[@"msg"]];
            }
            else {
                [SVProgressHUD showErrorWithStatus:json[@"msg"]];
            }
        } failure:^(NSError *error) {
            JXLog(@"请求失败 - %@", error);
        }];
    };
    
    footer.callButtonClickedAction = ^ {
        // 拨打电话按钮被点击
        NSString *str= @"tel:4221234567";
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    };
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [JXDetailFooterView footerHeight];
}

#pragma mark - JXTeacherDetailCellDelegate
- (void)teacherDetailCellDidClickedFeeDetailButton {
    JXFeeDetailController *feeDetailVC = [[JXFeeDetailController alloc] init];
    feeDetailVC.feeGroups = self.feeGroups;
    
    feeDetailVC.delegate = self;
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:feeDetailVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - JXFeeDetailControllerDelegate
- (void)feeDetailDidFinishedChooseWithFeeGroups:(NSArray *)feeGroups {
    self.feeGroups = feeGroups;
    
    [self.tableView reloadData];
}

- (void)dealloc {
    JXLog(@"JXTeacherDetailController - dealloc");
}
@end
