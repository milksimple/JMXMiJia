//
//  JXTeacherDetailCell.m
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherDetailCell.h"
#import "NSString+Extension.h"
#import "JXTeacher.h"

@interface JXTeacherDetailCell()
//@property (nonatomic, weak) UILabel *qualifiLabel;

//@property (nonatomic, weak) UILabel *qualifiContentLabel;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab3;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab4;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab5;
//@property (weak, nonatomic) IBOutlet UIView *sepView;
//@property (weak, nonatomic) IBOutlet UIView *circle1;
//@property (weak, nonatomic) IBOutlet UIView *circle2;
//@property (weak, nonatomic) IBOutlet UIView *circle3;
//@property (weak, nonatomic) IBOutlet UIView *circle5;
//@property (weak, nonatomic) IBOutlet UIView *circle6;

@property (weak, nonatomic) IBOutlet UILabel *qualifiLabel;
@property (weak, nonatomic) IBOutlet UILabel *signupCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@end

@implementation JXTeacherDetailCell

static NSString *intro = @"打发点附近阿迪设计费借力打力手机翻尽量少打飞机阿斯顿浪费大家萨芬吉林省到家了附近阿斯顿浪费拉动是解放军阿迪设计费 垃圾点附近拉三等奖 圣诞节弗拉圣诞节 的时间里房间爱上了就了解拉德斯基发链接啊 离开的减肥垃圾啊冻死了快放假了卡机拉动是浪费了教练的撒发的是解放军打死了房间爱大书法家了淑女坊拉伸的 烦死了放假了进来撒法拉利发";
- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
//    self.titleLab1.text = @"资质资格";
//    self.titleLab2.text = @"报名人数";
//    self.titleLab3.text = @"报名学费";
//    self.titleLab4.text = @"联系电话";
//    self.titleLab5.text = @"个人介绍";
    self.qualifiLabel.text = teacher.models;
    self.signupCountLabel.text = [NSString stringWithFormat:@"%zd人", teacher.signupCount];
    self.feeLabel.text = [NSString stringWithFormat:@"￥%.0f", teacher.price];
    self.phoneLabel.text = teacher.phone;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:intro];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:5];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, attributedStr.length)];
    self.introduceLabel.attributedText = attributedStr;
}

@end
