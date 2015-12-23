//
//  JXNavigationController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXNavigationController.h"

@interface JXNavigationController ()

@end

@implementation JXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置外观
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}


@end
