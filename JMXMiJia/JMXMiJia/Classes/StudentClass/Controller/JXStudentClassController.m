//
//  JXStudentClassController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//
// 存储最后一条评论的key
#define JXStudentProgressLastCommentKey @"JXStudentProgressLastCommentKey"
// 存储进度json数据的路径
#define JXStudentProgressJsonPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"studentProgressJson.archive"]

#import "JXStudentClassController.h"
#import "JXStudentProgressCell.h"
#import "JXStudentProgress.h"
#import "JXStudentProgressDetailCell.h"
#import "JXStudentScoreCell.h"
#import "JXStudentProgressHeader.h"
#import "JXStudentProgressFooter.h"
#import "JXStudentClassHeaderView.h"
#import <MJRefresh.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "JXToStudentComment.h"

@interface JXStudentClassController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 课堂进度 */
@property (nonatomic, strong) NSArray *progresses;
/** 最近的评论 */
@property (nonatomic, copy) NSString *lastComment;
/** 最近的评论日期 */
@property (nonatomic, copy) NSString *lastCommentDate;
/** 各行是否展开,展开为1，闭合为0 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *explands;
/** 当前选中的行 */
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation JXStudentClassController
#pragma mark - 懒加载
- (NSString *)lastComment {
    if (_lastComment == nil) {
        _lastComment = @"暂无对您的点评信息!";
    }
    return _lastComment;
}

- (NSMutableArray<NSNumber *> *)explands {
    if (_explands == nil) {
        _explands = @[@0, @0, @0, @0].mutableCopy;
    }
    return _explands;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的进度";
    
    [self setupTableView];
    
    // 先从本地解档
    id json = [NSKeyedUnarchiver unarchiveObjectWithFile:JXStudentProgressJsonPath];
    JXLog(@"local json = %@", json);
    if (json) {
        [self dealData:json];
    }
    
    [self setupRefresh];
    
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    // 添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadProgressData)];
    
    // 开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  获取下载进度数据
 */
- (void)loadProgressData {
    JXAccount *account = [JXAccountTool account];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
//    paras[@"mobile"] = account.mobile;
//    paras[@"password"] = account.password;
#warning 测试数据
    paras[@"mobile"] = @"13708803633";
    paras[@"password"] = @"111111";
    
    [JXHttpTool post:[NSString stringWithFormat:@"%@/TraineeReviewsList", JXServerName] params:paras success:^(id json) {
        [self.tableView.mj_header endRefreshing];
        
        BOOL success = [json[@"success"] boolValue];
        if (success) {
            // 将json归档
            [NSKeyedArchiver archiveRootObject:json toFile:JXStudentProgressJsonPath];
            // 处理数据
            [self dealData:json];
        }
        else {
            [SVProgressHUD showErrorWithStatus:json[@"msg"] maskType:SVProgressHUDMaskTypeBlack];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络连接失败" maskType:SVProgressHUDMaskTypeBlack];
        JXLog(@"请求失败 - %@", error);
    }];
    
}

/**
 *  处理数据
 *
 *  @param json 从服务器或者从本地沙盒获取的进度数据
 */
- (void)dealData:(id)json {
    JXLog(@"dealData remote json %@", json);
    NSMutableArray *progresses = [NSMutableArray array];
    // 4个科目进度
    for (int i = 1; i < 5; i ++) {
        NSString *stepName = [NSString stringWithFormat:@"step%zd", i];
        JXStudentProgress *progress = [JXStudentProgress mj_objectWithKeyValues:json[stepName]];
        progress.subjectNO = i;
        [progresses addObject:progress];
    }
    self.progresses = progresses;
    
    // 最近一条评论
    self.lastComment = json[@"lastDes"];
    
    // 最近一条评论的日期
    self.lastCommentDate = json[@"lastDate"];
    // 处理完数据刷新表格
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 4) {
        BOOL expland = [self.explands[section] boolValue];
        if (expland) {
            JXStudentProgress *progress = self.progresses[section];
            return progress.rows.count;
        }
        else return 0;
    }
    else { // 点评
        return 1;
    }
    
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 4) {
        JXStudentProgressDetailCell *detailCell = [JXStudentProgressDetailCell cell];
        JXStudentProgress *progress = self.progresses[indexPath.section];
        JXToStudentComment *comment = progress.rows[indexPath.row];
        detailCell.comment = comment;
        return detailCell;
    }
    
    else {
        JXStudentScoreCell *scoreCell = [JXStudentScoreCell cell];
        scoreCell.comment = self.lastComment;
        return scoreCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 4) {
        return [JXStudentProgressDetailCell rowHeight];
    }
    else {
        JXStudentScoreCell *scoreCell = [JXStudentScoreCell cell];
        scoreCell.comment = self.lastComment;
        return [scoreCell rowHeight];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section < 4) {
        JXStudentClassHeaderView *header = [JXStudentClassHeaderView header];
        header.progress = self.progresses[section];
        header.headerViewClickedAction = ^{
            BOOL expland = [self.explands[section] boolValue];
            self.explands[section] = @(!expland);
            [self.tableView reloadData];
            [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:0];
        };
        return header;
    }
    else { // 点评
        JXStudentProgressHeader *commentHeader = [JXStudentProgressHeader header];
        
        commentHeader.date = self.lastCommentDate;
        return commentHeader;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 4) {
        self.selectedIndexPath = indexPath;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 4) {
        return [JXStudentClassHeaderView headerHeight];
    }
    else {
        return [JXStudentProgressCell rowHeight];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        JXStudentProgressFooter *footer = [JXStudentProgressFooter footer];
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return [JXStudentProgressFooter footerHeight];
    }
    else {
        return 5;
    }
}
@end
