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

@interface JXStudentClassController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 课堂进度 */
@property (nonatomic, strong) NSArray *progresses;
@end

@implementation JXStudentClassController
#pragma mark - 懒加载
- (NSArray *)progresses {
    if (_progresses == nil) {
        NSMutableArray *progresses = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            JXStudentProgress *progress = [[JXStudentProgress alloc] init];
            progress.phrase = i + 1;
            if (i < 2) {
                progress.complete = YES;
                progress.startTime = @"2015年1月1日";
                progress.finishTime = @"2015年2月1日";
            }
            else {
                progress.complete = NO;
                progress.startTime = @"2015年3月1日";
            }
        }
        
        _progresses = progresses;
    }
    return _progresses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的进度";

    [self setupTableView];
    
    // 注册
    
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    }
    return 1;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JXStudentProgressCell *cell = [JXStudentProgressCell cell];
        return cell;
    }
    else if (indexPath.section == 1) {
        JXStudentProgressDetailCell *detailCell = [JXStudentProgressDetailCell cell];
        return detailCell;
    }
    else {
        JXStudentScoreCell *scoreCell = [JXStudentScoreCell cell];
        return scoreCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [JXStudentProgressCell rowHeight];
    }
    else if (indexPath.section == 1) {
        return [JXStudentProgressDetailCell rowHeight];
    }
    else {
        return [JXStudentScoreCell rowHeight];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXStudentProgressHeader *header = [JXStudentProgressHeader header];
    if (section == 0) {
        return nil;
    }
    else if (section == 1) {
        header.hideLabel = YES;
    }
    else {
        header.hideLabel = NO;
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [JXStudentProgressHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        JXStudentProgressFooter *footer = [JXStudentProgressFooter footer];
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return [JXStudentProgressFooter footerHeight];
    }
    else {
        return 1;
    }
}
@end
