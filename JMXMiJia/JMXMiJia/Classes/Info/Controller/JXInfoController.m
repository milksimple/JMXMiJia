//
//  JXInfoController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXInfoController.h"
//#import "JXInfoHeaderView.h"
//#import "JXMessageHeaderView.h"
#import "JXInfoTableViewCell.h"
#import "JXMessageTableViewCell.h"
#import <SDWebImageManager.h>

@interface JXInfoController () <SDWebImageManagerDelegate>

/** 各组展开情况
 *  0 代表闭合
 *  非0 代表展开，并代表改组有多少row
 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *isExplands;
@property (nonatomic, strong) SDWebImageManager *manager;
@end

@implementation JXInfoController

#pragma mark - 懒加载
- (NSMutableArray<NSNumber *> *)isExplands {
    if (_isExplands == nil) {
        _isExplands = [NSMutableArray array];
        for (int i = 0; i < 10; i ++) {
            [_isExplands addObject:@0];
        }
    }
    return _isExplands;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStylePlain]) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"最新资讯";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemClicked)];
    self.view.backgroundColor = JXGlobalBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JXInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"infoCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JXMessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"messageCell"];
#warning 测试
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    self.manager = manager;
//    manager.delegate = self;
//    [manager downloadImageWithURL:[NSURL URLWithString:@"http://10.255.1.25/dschoolAndroid/CoachPhoto?isSource=0&uid=14447074676731&size=14384"] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        JXLog(@"size = %@", NSStringFromCGSize(image.size));
//    }];

}

//#pragma mark - SDWebImageManagerDelegateÅ
//- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL {
//    JXLog(@"transformDownloadedImage------");
//    return image;
//}

/**
 *  编辑按钮被点击
 */
- (void)editItemClicked {
    BOOL editing = !self.tableView.editing;
    [self.tableView setEditing:editing animated:YES];
    self.navigationItem.rightBarButtonItem.title = editing ? @"完成" : @"编辑";
}

#pragma mark - tableview data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 10;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([self.isExplands[section] integerValue] == 1) {
//        return 1;
//    }
    return self.isExplands.count;
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = @"test";
//    return cell;
    if (indexPath.row % 2 == 0) {
        JXInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        return infoCell;
    }
    else {
        JXMessageTableViewCell *msgCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
        msgCell.corverButtonClickedAction = ^{
            self.isExplands[indexPath.row] = @(![self.isExplands[indexPath.row] integerValue]);
            [self.tableView reloadData];
        };
        msgCell.expland = [self.isExplands[indexPath.row] boolValue];
        return msgCell;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section % 2 == 0) {
////        JXInfoHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"infoHeader"];
////        if (headerView == nil) {
////            headerView = [[JXInfoHeaderView alloc] initWithReuseIdentifier:@"infoHeader"];
////        }
////        return headerView;
//    }
//    else {
//        JXMessageHeaderView *msgHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"msgHeader"];
//        if (msgHeader == nil) {
//            msgHeader = [[JXMessageHeaderView alloc] initWithReuseIdentifier:@"msgHeader"];
//        }
//        return msgHeader;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if ([self.isExplands[row] integerValue] == 1) { // 该行为展开
        JXMessageTableViewCell *explandCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        return [explandCell rowHeight];
    }
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JXLog(@"didSelectRowAtIndexPath = %@", indexPath);
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.isExplands removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}
@end
