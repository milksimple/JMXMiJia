//
//  JXDetailHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXDetailHeaderView.h"
#import "JXTeacher.h"
#import "JXSchool.h"

@interface JXDetailHeaderView()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *gradeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UIButton *signCountButton;
@property (weak, nonatomic) IBOutlet UIButton *distanceButton;

@end

@implementation JXDetailHeaderView

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXDetailHeaderView" owner:nil options:nil].lastObject;
}

+ (CGFloat)headerHeight {
    return 116;
}

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
    // sdwebImage设置头像
    self.gradeView.hidden = !teacher.grade;
#warning 测试数据
    self.iconView.image = [UIImage imageNamed:@"icon_example"];
    self.nameLabel.text = teacher.name;
    self.sexView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sex_%zd", teacher.sex]];
    self.schoolLabel.text = teacher.school;
    self.starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%zd", teacher.star]];
    [self.signCountButton setTitle:[NSString stringWithFormat:@"%zd 人", teacher.signupCount] forState:UIControlStateNormal];
    [self.distanceButton  setTitle:[NSString stringWithFormat:@"%.1fkm", teacher.distance] forState:UIControlStateNormal];
}

@end
