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
#import "UIView+Extension.h"

@interface JXTeacherController ()

@property (nonatomic, strong) NSMutableArray *teachers;

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[JXTeacherViewCell class] forCellReuseIdentifier:@"teacher"];
    self.tableView.rowHeight = 70;
    
    [self setupSearchBar];
}

- (void)setupSearchBar {
    NSLog(@"宽度 = %f", [UIScreen mainScreen].bounds.size.width);
    JXSearchBar *searchBar = [[JXSearchBar alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 64)];
//    searchBar.frame = CGRectMake(0, 64, self.view.width, 64);
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    [self.tableView addSubview:searchBar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teachers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTeacherViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacher" forIndexPath:indexPath];
    cell.teacher = self.teachers[indexPath.row];
    return cell;
}

@end
