//
//  JXAutoOrderController.m
//  JMXMiJia
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXAutoOrderController.h"
#import "JXSearchParas.h"
#import <MJExtension.h>
#import "JXBaseFeeCell.h"
#import "JXOptionalFeeCell.h"
#import "JXAccommodationFeeCell.h"
#import "JXTeacherFeeCell.h"
#import "JXStudyPlaceCell.h"
#import "JXFee.h"
#import "JXFeeGroup.h"
#import "JXChooseSchoolController.h"
#import "JXAutoOrderHeaderView.h"
#import "JXAutoOrderFooterView.h"

@interface JXAutoOrderController () <JXAccommodationFeeCellDelegate, JXChooseSchoolControllerDelegate, JXAutoOrderFooterViewDelegate>

/** 费用数组 */
@property (nonatomic, strong) NSArray *feeGroups;
@end

@implementation JXAutoOrderController
// 重用标示
static NSString * const JXOptionalFeeID = @"optionalFeeCell";

#pragma mark - 懒加载
- (NSArray *)feeGroups {
    if (_feeGroups == nil) {
        _feeGroups = [JXFeeGroup mj_objectArrayWithFilename:@"feeGroup.plist"];
    }
    return _feeGroups;
}

- (void)setSearchParas:(JXSearchParas *)searchParas {
    _searchParas = searchParas;
    
    self.feeGroups = searchParas.feeGroups;
}

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"自主订单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    // 注册
    // 基础费用cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JXBaseFeeCell" bundle:nil] forCellReuseIdentifier:[JXBaseFeeCell reuseIdentifier]];
    // 可选费用cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JXOptionalFeeCell" bundle:nil] forCellReuseIdentifier:[JXOptionalFeeCell reuseIdentifier]];
    // 教练
    [self.tableView registerNib:[UINib nibWithNibName:@"JXTeacherFeeCell" bundle:nil] forCellReuseIdentifier:[JXTeacherFeeCell reuseIdentifier]];
}

/**
 *  取消
 */
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
        JXFeeGroup *feeGroup = self.feeGroups[section];
        NSArray *fees = feeGroup.fees;
        return fees.count;
    }
    // 驾校
    return 1;
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXFee *fee = nil;
    if (indexPath.section < 3) {
        JXFeeGroup *feeGroup = self.feeGroups[indexPath.section];
        fee = feeGroup.fees[indexPath.row];
    }

    if (indexPath.section == 0) { // 基础费用
        JXBaseFeeCell *baseFeeCell = [tableView dequeueReusableCellWithIdentifier:[JXBaseFeeCell reuseIdentifier] forIndexPath:indexPath];
        baseFeeCell.fee = fee;
        return baseFeeCell;
    }
    
    else if (indexPath.section == 1) { // 可选费用
        if (indexPath.row < 4) { // 可选费用
            JXOptionalFeeCell *optionalFeeCell = [tableView dequeueReusableCellWithIdentifier:[JXOptionalFeeCell reuseIdentifier] forIndexPath:indexPath];
            optionalFeeCell.fee = fee;
            optionalFeeCell.optionalButtonClickedAction = ^{
                fee.copies = !fee.copies;
                [self.tableView reloadData];
            };
            return optionalFeeCell;
        }

        else { // 长途食宿费
            JXAccommodationFeeCell *accommFeeCell = [JXAccommodationFeeCell cell];
            accommFeeCell.delegate = self;
            accommFeeCell.fee = fee;
            return accommFeeCell;
        }
    }
    
    else if (indexPath.section == 2) { // 选择教练
        JXTeacherFeeCell *teacherFeeCell = [tableView dequeueReusableCellWithIdentifier:[JXTeacherFeeCell reuseIdentifier] forIndexPath:indexPath];
        teacherFeeCell.fee = fee;
        teacherFeeCell.optionalButtonClickedAction = ^{
            // 先将所有教练选项设置为0
            JXFeeGroup *feeGroup = self.feeGroups[2];
            NSArray *fees = feeGroup.fees;
            [fees makeObjectsPerformSelector:@selector(setCopies:) withObject:0];
            
            // 设置当前教练选项为1
            fee.copies = !fee.copies;
            self.searchParas.star = fees.count - 1 - indexPath.row;
            [self.tableView reloadData];
        };
        return teacherFeeCell;
    }
    
    else { // 选择驾校
        JXStudyPlaceCell *studyPlaceCell = [JXStudyPlaceCell cell];
        studyPlaceCell.school = self.searchParas.school;
        return studyPlaceCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 3) {
        return 88;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) { // 选择场地
        JXChooseSchoolController *chooseSchoolVC = [[JXChooseSchoolController alloc] init];
        chooseSchoolVC.delegate = self;
        chooseSchoolVC.defaultSchool = self.searchParas.school;
        [self.navigationController pushViewController:chooseSchoolVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXAutoOrderHeaderView *header = [JXAutoOrderHeaderView headerView];
    if (section < 3) {
        header.feeGroup = self.feeGroups[section];
    }
    else {
        header.title = @"选择场地";
    }
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) { // 最下面的确定按钮
        JXAutoOrderFooterView *footer = [JXAutoOrderFooterView footerView];
        footer.totalPay = [self calculateTotalPay];
        footer.delegate = self;
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 70;
    }
    return 0.1;
}

/**
 *  计算总价
 */
- (NSInteger)calculateTotalPay {
    NSInteger totalPay = 0;
    for (JXFeeGroup *feeGroup in self.feeGroups) {
        for (JXFee *fee in feeGroup.fees) {
            totalPay += fee.fee * fee.copies;
        }
    }
    return totalPay;
}

#pragma mark - JXAccommodationFeeCellDelegate
- (void)accommodationFeeCellDidClickedPlusButton {
    // 食宿费
    JXFeeGroup *feeGroup = self.feeGroups[1];
    JXFee *fee = feeGroup.fees[4];
    fee.copies += 1;
    [self.tableView reloadData];
}

- (void)accommodationFeeCellDidClickedMinusButton {
    // 食宿费
    JXFeeGroup *feeGroup = self.feeGroups[1];
    JXFee *fee = feeGroup.fees[4];
    if (fee.copies == 0) return;
    fee.copies -= 1;
    [self.tableView reloadData];
}

#pragma mark - JXChooseSchoolControllerDelegate
- (void)chooseSchoolDidFinished:(JXSchool *)school {
    self.searchParas.school = school;
    [self.tableView reloadData];
}

#pragma mark - JXAutoOrderFooterViewDelegate
- (void)autoOrderFooterViewDidClickedConfirmButton {
    [self dismissViewControllerAnimated:YES completion:^{
        self.searchParas.feeGroups = self.feeGroups;
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(autoOrderDidFinishedWithSearchParas:)]) {
            [self.delegate autoOrderDidFinishedWithSearchParas:self.searchParas];
        }
    }];
}

@end
