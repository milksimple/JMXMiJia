//
//  JXStudentClassController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXStudentClassController.h"
#import "JXStudentProgressCell.h"

@interface JXStudentClassController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation JXStudentClassController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else {
        return 1;
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXStudentProgressCell *cell = [JXStudentProgressCell cell];
    
}
@end
