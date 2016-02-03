//
//  JXFilterViewController.m
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

// 标题数组
#define JXTitles @[@"星级", @"学校", @"性别"]

#import "JXFilterViewController.h"
#import "JXSearchParas.h"
#import "JXChooseStarController.h"
#import "JXChooseSchoolController.h"
#import "JXChooseSexController.h"

@interface JXFilterViewController () <JXChooseStarControllerDelegate, JXChooseSchoolControllerDelegate, JXChooseSexControllerDelegate>
/** 搜索参数 */
@property (nonatomic, strong) JXSearchParas *searchParas;

@property (nonatomic, strong) JXChooseStarController *chooseStarVC;

@property (nonatomic, strong) JXChooseSchoolController *chooseSchoolVC;

@property (nonatomic, strong) JXChooseSexController *chooseSexVC;
@end

@implementation JXFilterViewController

static NSString * const ID = @"filterViewCell";

#pragma mark - 懒加载
- (JXSearchParas *)searchParas {
    if (_searchParas == nil) {
        _searchParas = [[JXSearchParas alloc] init];
    }
    return _searchParas;
}

- (JXChooseStarController *)chooseStarVC {
    if (_chooseStarVC == nil) {
        _chooseStarVC = [[JXChooseStarController alloc] init];
        _chooseStarVC.delegate = self;
    }
    return _chooseStarVC;
}

- (JXChooseSchoolController *)chooseSchoolVC {
    if (_chooseSchoolVC == nil) {
        _chooseSchoolVC = [[JXChooseSchoolController alloc] init];
        _chooseSchoolVC.delegate = self;
    }
    return _chooseSchoolVC;
}

- (JXChooseSexController *)chooseSexVC {
    if (_chooseSexVC == nil) {
        _chooseSexVC = [[JXChooseSexController alloc] init];
        _chooseSexVC.delegate = self;
    }
    return _chooseSexVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"筛选";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 左上角按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    // 右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
}

/**
 *  取消筛选
 */
- (void)cancel {
    // 发送通知
    [JXNotificationCenter postNotificationName:JXFilterViewClickedCancelButtonNotification object:nil userInfo:nil];
}

/**
 *  确定
 */
- (void)confirm {
    [JXNotificationCenter postNotificationName:JXFilterViewClickedConfirmButtonNotification object:nil userInfo:@{@"JXSearchParasKey":self.searchParas}];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return JXTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = cell.textLabel.font;
    }
    cell.textLabel.text = JXTitles[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = self.searchParas.star;
            if (cell.detailTextLabel.text == nil) {
                cell.detailTextLabel.text = @"不限";
            }
            break;
        case 1:
            cell.detailTextLabel.text = self.searchParas.school;
            if (cell.detailTextLabel.text == nil) {
                cell.detailTextLabel.text = @"不限";
            }
            break;
        case 2:
            cell.detailTextLabel.text = self.searchParas.sex;
            if (cell.detailTextLabel.text == nil) {
                cell.detailTextLabel.text = @"不限";
            }
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selectedCell.selected = NO;
    });
    
    switch (indexPath.row) {
        case 0: { // 星级
//            JXChooseStarController *chooseStarVC = [[JXChooseStarController alloc] init];
//            chooseStarVC.delegate = self;
//            chooseStarVC.defaultStar = self.searchParas.star;
            [self.navigationController pushViewController:self.chooseStarVC animated:YES];
        }
            break;
        case 1: { // 学校
//            JXChooseSchoolController *chooseSchoolVC = [[JXChooseSchoolController alloc] init];
//            chooseSchoolVC.delegate = self;
//            chooseSchoolVC.defaultSchool = self.searchParas.school;
            [self.navigationController pushViewController:self.chooseSchoolVC animated:YES];
        }
            break;
        case 2: {// 性别
//            JXChooseSexController *chooseSexVC = [[JXChooseSexController alloc] init];
//            chooseSexVC.delegate = self;
//            chooseSexVC.defaultSex = self.searchParas.sex;
            [self.navigationController pushViewController:self.chooseSexVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - JXChooseStarControllerDelegate
- (void)chooseStarDidFinished:(NSString *)star {
    self.searchParas.star = star;
    [self.tableView reloadData];
}

#pragma mark - JXChooseSchoolControllerDelegate
- (void)chooseSchoolDidFinished:(NSString *)school {
    self.searchParas.school = school;
    [self.tableView reloadData];
}

#pragma mark - JXChooseSexControllerDelegate
- (void)chooseSexDidFinished:(NSString *)sex {
    self.searchParas.sex = sex;
    [self.tableView reloadData];
}

- (void)dealloc {
    JXLog(@"dealloc");
}

@end