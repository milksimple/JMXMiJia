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

@interface JXTeacherDetailController ()

@end

@implementation JXTeacherDetailController

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
#warning 还没设置数据
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
        // 报名按钮被点击
        
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

@end
