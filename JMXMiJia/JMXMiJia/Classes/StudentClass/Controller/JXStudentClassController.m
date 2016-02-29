//
//  JXStudentClassController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

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

@interface JXStudentClassController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 课堂进度 */
@property (nonatomic, strong) NSArray *progresses;
/** 各行是否展开,展开为1，闭合为0 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *explands;
@end

@implementation JXStudentClassController
#pragma mark - 懒加载
- (NSArray *)progresses {
    if (_progresses == nil) {
        NSMutableArray *progresses = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            JXStudentProgress *progress = [[JXStudentProgress alloc] init];
            progress.phrase = i;
            progress.phraseStatus = JXStudentProgressPhraseStatusNotStart;
            [progresses addObject:progress];
        }
        
        _progresses = progresses;
    }
    return _progresses;
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
    paras[@"mobile"] = account.mobile;
    paras[@"password"] = account.password;
    [JXHttpTool post:[NSString stringWithFormat:@"%@/TraineeStep", JXServerName] params:paras success:^(id json) {
        [self.tableView.mj_header endRefreshing];
        JXLog(@"%@", json);
        BOOL success = [json[@"success"] boolValue];
        if (success) {
            NSInteger step = [json[@"step"] integerValue];
            NSArray *finishDates = json[@"date"];
            // step为在学
            JXStudentProgress *progress = self.progresses[step];
            
            progress.phraseStatus = JXStudentProgressPhraseStatusStuding;
            
            // step之前为学完
            for (NSInteger i = step - 1; i >= 0; i --) {
                JXStudentProgress *progress = self.progresses[i];
                progress.finishTime = finishDates[i];
                progress.phraseStatus = JXStudentProgressPhraseStatusComplete;
                
            }
            
            // step之后为未开始
            for (NSInteger i = step + 1; i < 4; i ++) {
                JXStudentProgress *progress = self.progresses[i];
                progress.phraseStatus = JXStudentProgressPhraseStatusNotStart;

            }
            [self.tableView reloadData];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 4) {
        BOOL expland = [self.explands[section] boolValue];
        if (expland) {
#warning 测试数据
            return 4;
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
//        
//        detailCell.corverButtonClickedAction = ^{
//            
//        };
        return detailCell;
    }
    
    else {
        JXStudentScoreCell *scoreCell = [JXStudentScoreCell cell];
        scoreCell.commentLabel.text = @"热心肠，本着只有教不好的老师，没有教不会的学生。热心肠，本着只有教不好的老师，没有教不会的学生。热心肠，本着只有教不好的老师，没有教不会的学生。热心肠，本着只有教不好的老师，没有教不会的学生。";
        return scoreCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 4) {
        return [JXStudentProgressDetailCell rowHeight];
    }
    else {
        JXStudentScoreCell *scoreCell = [JXStudentScoreCell cell];
        scoreCell.commentLabel.text = @"热心肠，本着只有教不好的老师，没有教不会的学生。热心肠，本着只有教不好的老师，没有教不会的学生。热心肠，本着只有教不好的老师，没有教不会的学生。热心肠，本着只有教不好的老师，没有教不会的学生。";
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
        };
        return header;
    }
    else { // 点评
        JXStudentProgressHeader *commentHeader = [JXStudentProgressHeader header];
        return commentHeader;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selectedCell.selected = NO;
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [JXStudentClassHeaderView headerHeight];
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
        return 0.1;
    }
}
@end
