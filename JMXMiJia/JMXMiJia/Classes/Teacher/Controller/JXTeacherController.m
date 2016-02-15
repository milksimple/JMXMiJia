//
//  JXTeacherController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXTeacherController.h"
#import "JXTeacherViewCell.h"
#import "JXTeacher.h"
#import "JXSearchBar.h"
#import "JXTeacherToolBar.h"
#import "UIView+Extension.h"
#import <BBBadgeBarButtonItem.h>
#import "JXNavLetterButton.h"
#import "JXTeacherDetailController.h"
#import "JXTeacherHeaderView.h"
#import "JXHttpTool.h"
#import "JXAccount.h"
#import "JXAccountTool.h"
#import <MJExtension.h>
#import "JXTeachersTool.h"
#import "JXSearchParas.h"
#import "JXFilterView.h"
#import "JXNavigationController.h"
#import "JXFilterViewController.h"
#import <MJRefresh.h>
#import "JXAutoOrderController.h"

@interface JXTeacherController () <UITableViewDataSource, UITableViewDelegate, JXSearchBarDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIView *toolView;

@property (nonatomic, weak) JXSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *teachers;
/** tableview上次滚动到的contentOffset的y值 */
@property (nonatomic, assign) CGFloat lastScroolY;
/** 是否正在拖动tableview */
@property (nonatomic, assign) BOOL draging;
/** 筛选参数 */
@property (nonatomic, strong) JXSearchParas *searchParas;
/** 筛选view */
@property (nonatomic, weak) JXFilterView *filterView;
/** 筛选控制器 */
@property (nonatomic, strong) JXFilterViewController *filterVC;
@end

@implementation JXTeacherController

#pragma mark - 懒加载
- (NSMutableArray *)teachers {
    if (_teachers == nil) {
        _teachers = [NSMutableArray array];
//        for (int i = 0; i < 20; i ++) {
//            JXTeacher *teacher = [[JXTeacher alloc] init];
//            teacher.name = [NSString stringWithFormat:@"黄志刚%d", i];
//            teacher.school = @"达睿驾校";
//            teacher.rank = i % 3 + 1;
//            teacher.workYear = 5;
//            teacher.teachType = @"C1";
//            teacher.fee = (i % 3 + 1) * 2000;
//            teacher.introduction = @"打发点附近阿迪设计费借力打力手机翻尽量少打飞机阿斯顿浪费大家萨芬吉林省到家了附近阿斯顿浪费拉动是解放军阿迪设计费 垃圾点附近拉三等奖 圣诞节弗拉圣诞节 的时间里房间爱上了就了解拉德斯基发链接啊 离开的减肥垃圾啊冻死了快放假了卡机拉动是浪费了教练的撒发的是解放军打死了房间爱大书法家了淑女坊拉伸的 烦死了放假了进来撒法拉利发";
//            teacher.signupCount = 133;
//            teacher.phone = @"422-1234-567";
//            [_teachers addObject:teacher];
//        }
    }
    return _teachers;
}

- (JXSearchParas *)searchParas {
    if (_searchParas == nil) {
        _searchParas = [[JXSearchParas alloc] init];
        _searchParas.star = -1;
    }
    return _searchParas;
}

- (JXFilterViewController *)filterVC {
    if (_filterVC == nil) {
        _filterVC = [[JXFilterViewController alloc] init];
    }
    return _filterVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"报名"];

    [self setupTableView];
    
    [self setupToolView];
    
    // 监听通知
    [self addNotificationObserver];
    
    [self setupRefresh];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.contentInset = UIEdgeInsetsMake([JXSearchBar height], 0, 0, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 80;
    
    [self.tableView registerClass:[JXTeacherViewCell class] forCellReuseIdentifier:@"teacher"];
}

- (void)setupToolView {
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = [UIColor redColor];
    JXSearchBar *searchBar = [[JXSearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, JXScreenW, [JXSearchBar height]);
    [toolView addSubview:searchBar];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    
    toolView.frame = CGRectMake(0, 64, JXScreenW, CGRectGetMaxY(searchBar.frame));
    [self.view insertSubview:toolView aboveSubview:self.tableView];
    self.toolView = toolView;
}

/**
 *  监听通知
 */
- (void)addNotificationObserver {
    // 监听通知
    [JXNotificationCenter addObserver:self selector:@selector(filterViewClickedCancelButton) name:JXFilterViewClickedCancelButtonNotification object:nil];
    [JXNotificationCenter addObserver:self selector:@selector(filterViewClickedConfirmButton:) name:JXFilterViewClickedConfirmButtonNotification object:nil];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    // 添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTeachers)];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTeachers)];
    
    // 开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  加载最新教练列表
 */
- (void)loadNewTeachers {
    // 1.拼接请求参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"mobile"] = self.searchParas.mobile;
    paras[@"password"] = self.searchParas.password;
    paras[@"keyword"] = self.searchParas.keyword;
    paras[@"sex"] = @(self.searchParas.sex);
    paras[@"star"] = @(self.searchParas.star);
    paras[@"school"] = self.searchParas.school;
    
    // 取出最前面的老师
    [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/CoachFace" params:paras success:^(id json) {
        // 停止刷新状态
        [self.tableView.mj_header endRefreshing];
        
        // 字典数组转模型数组
        NSArray *newTeachers = [JXTeacher mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        [self.teachers insertObjects:newTeachers atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newTeachers.count)]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        JXLog(@"请求失败 - %@", error);
    }];
}

- (void)loadMoreTeachers {
    // 1.拼接请求参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"start"] = [NSString stringWithFormat:@"%zd", self.teachers.count];
    paras[@"mobile"] = self.searchParas.mobile;
    paras[@"password"] = self.searchParas.password;
    paras[@"keyword"] = self.searchParas.keyword;
    paras[@"sex"] = @(self.searchParas.sex);
    paras[@"star"] = @(self.searchParas.star);
    paras[@"school"] = self.searchParas.school;
    
    // 取出后面的老师
    [JXHttpTool post:@"http://10.255.1.25/dschoolAndroid/CoachFace" params:paras success:^(id json) {
        // 停止刷新状态
        [self.tableView.mj_footer endRefreshing];
        
        // 字典数组转模型数组
        NSArray *moreTeachers = [JXTeacher mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        [self.teachers addObjectsFromArray:moreTeachers];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        JXLog(@"请求失败 - %@", error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - JXSearchBarDelegate
/**
 *  搜索按钮被点击了
 */
- (void)searchBarButtonDidClickedWithSearchContent:(NSString *)searchContent {
    // 发送请求
    self.searchParas.keyword = searchContent;
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  搜索框中的内容清空了
 */
- (void)searchBarDidClearedSearchText {
    // 发送请求
    self.searchParas.keyword = nil;
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  筛选按钮被点击了
 */
- (void)searchBarDidClickedFilterButton {
    JXFilterView *filterView = [JXFilterView filterView];
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:self.filterVC];
    filterView.contentViewController = nav;
    [filterView show];
    self.filterView = filterView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teachers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTeacherViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacher" forIndexPath:indexPath];
    cell.teacher = self.teachers[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
/*
 * 上滚动工具栏隐藏，下滚动工具栏出现
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.draging = YES;
    self.lastScroolY = scrollView.contentOffset.y;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.draging = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar quitKeyboard];
    
    if (self.draging == NO) return;
    
    if (scrollView.contentOffset.y > self.lastScroolY) {
        if (self.toolView.hidden == NO) {
            [UIView animateWithDuration:0.25 animations:^{
                self.toolView.y = - [JXSearchBar height];
            } completion:^(BOOL finished) {
                self.toolView.hidden = YES;
            }];
        }
        
    }
    else {
        if (self.toolView.hidden == YES) {
            self.toolView.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                self.toolView.y = 64;
            }];
        }
        
    }
}
*/

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTeacher *teacher = self.teachers[indexPath.row];
    JXTeacherDetailController *detailVC = [[JXTeacherDetailController alloc] initWithStyle:UITableViewStylePlain];
    detailVC.teacher = teacher;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXTeacherHeaderView *header = [JXTeacherHeaderView headerView];
    
    __weak typeof(self) weakSelf = self;
    header.orderButtonClickedAction = ^{
        JXAutoOrderController *autoOrderVC = [[JXAutoOrderController alloc] init];
        JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:autoOrderVC];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [JXTeacherHeaderView headerHeight];
}


#pragma mark - filterView的通知
/**
 *  筛选控制器view的取消按钮被点击了
 */
- (void)filterViewClickedCancelButton {
    [self.filterView dismiss];
}

/**
 *  筛选控制器view的确认按钮被点击了
 */
- (void)filterViewClickedConfirmButton:(NSNotification *)noti {
    [self.filterView dismiss];
    NSDictionary *userInfo = noti.userInfo;
    JXSearchParas *searchParas = userInfo[@"JXSearchParasKey"];
    self.searchParas = searchParas;
    [self.tableView.mj_header beginRefreshing];
}

@end
