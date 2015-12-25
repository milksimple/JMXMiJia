//
//  JXTabBarController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXTabBarController.h"
#import "JXNavigationController.h"
#import "JXInfoController.h"
#import "JXTeacherController.h"
#import "JXTeacherClassController.h"
#import "JXTeacherProfileController.h"
#import "JXStudentClassController.h"
#import "JXStudentController.h"
#import "JXStudentProfileController.h"

@interface JXTabBarController ()

@end

@implementation JXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    JXInfoController *infoVC = [[JXInfoController alloc] init];
    [self addChildVC:infoVC image:@"tabbar_info_normal" selectedImage:@"tabbar_info_selected" title:@"资讯"];
    
    JXTeacherController *teacherVC = [[JXTeacherController alloc] init];
    [self addChildVC:teacherVC image:@"tabbar_person_normal" selectedImage:@"tabbar_person_selected" title:@"老师"];
    
    JXTeacherClassController *teacherClassVC = [[JXTeacherClassController alloc] init];
    [self addChildVC:teacherClassVC image:@"tabbar_class_normal" selectedImage:@"tabbar_class_selected" title:@"课堂"];
    
    JXTeacherProfileController *teacherProfileVC = [[JXTeacherProfileController alloc] init];
    [self addChildVC:teacherProfileVC image:@"tabbar_profile_normal" selectedImage:@"tabbar_profile_selected" title:@"个人"];
    
}

- (void)addChildVC:(UIViewController *)childVC image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    childVC.view.backgroundColor = [UIColor whiteColor];
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.title = title;
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(177, 177, 177)} forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(82, 195, 233)} forState:UIControlStateSelected];
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end