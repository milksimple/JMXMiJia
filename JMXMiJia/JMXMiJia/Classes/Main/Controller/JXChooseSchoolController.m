//
//  JXChooseSchoolController.m
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXChooseSchoolController.h"
#import "JXHttpTool.h"
#import "JXAccount.h"
#import "JXAccountTool.h"
#import "NSString+MD5.h"
#import "JXSchool.h"
#import <MJExtension.h>
#import <MJRefresh.h>

@interface JXChooseSchoolController ()
/** 学校数组 */
@property (nonatomic, strong) NSMutableArray *schools;
@property (nonatomic, assign) NSInteger selectedRow;
@end

@implementation JXChooseSchoolController

- (NSMutableArray *)schools {
    if (_schools == nil) {
        _schools = [NSMutableArray array];
    }
    return _schools;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择学校";
    
    // 添加刷新控件
    [self loadSchools];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

/**
 *  添加刷新控件

- (void)setupRefresh {
    // 添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadSchools)];
    
    // 开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
}
  */

/**
 *  加载学校数据
 */
- (void)loadSchools {
//    if (self.schools.count) { // 有值
//        [self.tableView reloadData];
//        return;
//    }
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    JXAccount *account = [JXAccountTool account];
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
//#warning 测试数据
//    paras[@"mobile"] = @"15833913973";
//    paras[@"password"] = [NSString md5:@"123456"];
    // 发送请求
    [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/SchoolList" params:paras success:^(id json) {
        BOOL success = [json[@"success"] boolValue];
        if (success) { // 请求成功
            self.schools = [JXSchool mj_objectArrayWithKeyValuesArray:json[@"rows"]];
            
            // 假数据
            JXSchool *school = [[JXSchool alloc] init];
            school.name = @"不限";
            [self.schools insertObject:school atIndex:0];
            
            for (int i = 0; i < self.schools.count; i ++) {
                JXSchool *school = self.schools[i];
                if (self.defaultSchool == school.name) {
                    self.selectedRow = i;
                }
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
        else { // 请求错误
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        JXLog(@"请求失败 -- %@", error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.schools.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"filterSchoolCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.tintColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = cell.textLabel.font;
    }
    JXSchool *school = self.schools[indexPath.row];
    cell.textLabel.text = school.name;
    
    // 默认选中
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == self.selectedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.row;
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    selectedCell.tintColor = [UIColor lightGrayColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selectedCell.selected = NO;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    // 通知代理选择的项目
    if ([self.delegate respondsToSelector:@selector(chooseSchoolDidFinished:)]) {
        JXSchool *school = self.schools[indexPath.row];
        NSString *name = school.name;
        if ([name isEqualToString:@"不限"]) {
            name = nil;
        }
        [self.delegate chooseSchoolDidFinished:name];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *deselectedCell = [tableView cellForRowAtIndexPath:indexPath];
    deselectedCell.accessoryType = UITableViewCellAccessoryNone;
}


@end
