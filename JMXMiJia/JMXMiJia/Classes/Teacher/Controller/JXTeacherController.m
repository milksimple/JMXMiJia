//
//  JXTeacherController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXTeacherController.h"
#import "JXTeacherViewCell.h"

@interface JXTeacherController ()

@end

@implementation JXTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"教练列表";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JXTeacherViewCell" bundle:nil] forCellReuseIdentifier:@"teacher"];
    self.tableView.rowHeight = 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXTeacherViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacher" forIndexPath:indexPath];
    NSLog(@"%f", cell.iconButton.frame.size.width);
    return cell;
}

@end
