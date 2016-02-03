//
//  JXAutoOrderController.m
//  JMXMiJia
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXAutoOrderController.h"
#import "JXBaseFee.h"
#import "JXOptionalFee.h"
#import "JXSearchParas.h"
#import <MJExtension.h>
#import "JXBaseFeeCell.h"

@interface JXAutoOrderController ()
/** 所有基础费用 */
@property (nonatomic, strong) NSMutableArray *baseFees;
/** 所有可选费用 */
@property (nonatomic, strong) NSMutableArray *optionalFees;
/** 筛选模型 */
@property (nonatomic, strong) JXSearchParas *searchParas;
@end

@implementation JXAutoOrderController
// 重用标示
static NSString * const JXOptionalFeeID = @"optionalFeeCell";

#pragma mark - 懒加载
- (NSMutableArray *)baseFees {
    if (_baseFees == nil) {
        _baseFees = [JXBaseFee mj_objectArrayWithFilename:@"baseFeeList.plist"];
    }
    
    return _baseFees;
}

- (NSMutableArray *)optionalFees {
    if (_optionalFees == nil) {
        _optionalFees = [JXOptionalFee mj_objectArrayWithFilename:@"optionalFeeList.plist"];
    }
    return _optionalFees;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"自主订单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    // 注册
    [self.tableView registerClass:[JXBaseFeeCell class] forCellReuseIdentifier:[JXBaseFeeCell reuseIdentifier]];
}

/**
 *  取消
 */
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view datasource
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.baseFees.count;
    }
    else {
        return self.optionalFees.count;
    }
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) { // 第0组
        JXBaseFeeCell *cell = [tableView dequeueReusableCellWithIdentifier:[JXBaseFeeCell reuseIdentifier] forIndexPath:indexPath];
        JXBaseFee *baseFee = self.baseFees[indexPath.row];
        cell.textLabel.text = baseFee.feeName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%zd", baseFee.fee];
//    }
    
//    else { // 第1组
//        
//    }
    return cell;
}

@end
