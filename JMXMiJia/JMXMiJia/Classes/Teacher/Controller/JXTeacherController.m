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

@interface JXTeacherController () <UITableViewDataSource, UITableViewDelegate, JXSearchBarDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIView *toolView;

@property (nonatomic, weak) JXSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *teachers;
/** tableview上次滚动到的contentOffset的y值 */
@property (nonatomic, assign) CGFloat lastScroolY;
/** 是否正在拖动tableview */
@property (nonatomic, assign) BOOL draging;
@end

@implementation JXTeacherController

#pragma mark - 懒加载
- (NSMutableArray *)teachers {
    if (_teachers == nil) {
        _teachers = [NSMutableArray array];
        for (int i = 0; i < 20; i ++) {
            JXTeacher *teacher = [[JXTeacher alloc] init];
            teacher.name = [NSString stringWithFormat:@"黄志刚%d", i];
            teacher.school = @"达睿驾校";
            teacher.rank = i % 3 + 1;
            teacher.workYear = 5;
            teacher.teachType = @"C1";
            teacher.fee = (i % 3 + 1) * 2000;
            [_teachers addObject:teacher];
        }
    }
    return _teachers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"教练列表"];

    [self setupTableView];
    
    [self setupToolView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.contentInset = UIEdgeInsetsMake(64 + 50, 0, 0, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 70;
    
    [self.tableView registerClass:[JXTeacherViewCell class] forCellReuseIdentifier:@"teacher"];
}

- (void)setupToolView {
    UIView *toolView = [[UIView alloc] init];
    
    JXSearchBar *searchBar = [[JXSearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, JXScreenW, [JXSearchBar height]);
    [toolView addSubview:searchBar];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    
#warning xib为什么不行
//    JXTeacherToolBar *toolBar = [JXTeacherToolBar toolbar];
    JXTeacherToolBar *toolBar = [[JXTeacherToolBar alloc] init];
    toolBar.frame = CGRectMake(0, CGRectGetMaxY(searchBar.frame), JXScreenW, [JXTeacherToolBar height]);
    [toolView addSubview:toolBar];
    
    toolView.frame = CGRectMake(0, 64, JXScreenW, CGRectGetMaxY(toolBar.frame));
    [self.view insertSubview:toolView aboveSubview:self.tableView];
    self.toolView = toolView;
}

#pragma mark - JXSearchBarDelegate
/**
 *  搜索按钮被点击了
 */
- (void)searchBarButtonDidClickedWithSearchContent:(NSString *)searchContent {
#warning 调用服务器接口
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
                self.toolView.y = - 50;
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

@end
