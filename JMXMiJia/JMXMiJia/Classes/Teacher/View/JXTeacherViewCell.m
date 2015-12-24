//
//  JXTeacherViewCell.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#define JXNameFont [UIFont systemFontOfSize:17] // 姓名字体
#define JXSchoolFont [UIFont systemFontOfSize:12] // 学校字体
#define JXSignFont [UIFont systemFontOfSize:13] // 标签字体(等级，工作年限，教授类别)
#define JXFeeFont [UIFont systemFontOfSize:20] // 费用字体
#define JXDistanceFont JXSchoolFont

#import "JXTeacherViewCell.h"
#import <Masonry.h>
#import "JXTeacher.h"

@interface JXTeacherViewCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
/** 勋章 */
@property (nonatomic, weak) UIImageView *medalView;
/** 姓名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 驾校 */
@property (nonatomic, weak) UILabel *schoolLabel;
/** 距离 */
@property (nonatomic, weak) UIButton *distanceView;
/** 教师等级 */
@property (nonatomic, weak) UILabel *rankLabel;
/** 工作年限 */
@property (nonatomic, weak) UILabel *workYearLabel;
/** 教授类别 */
@property (nonatomic, weak) UILabel *teachTypeLabel;
/** 学费 */
@property (nonatomic, weak) UILabel *feeLabel;
@end

@implementation JXTeacherViewCell
// 控件之间的间距
static NSInteger const margin = 5;
// 标签的长度
static CGFloat const JXSignLabelW = 30;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setup];
    }
    return self;
}

- (void)setup {
    /** 头像 */
    UIButton *iconButton = [[UIButton alloc] init];
    iconButton.layer.cornerRadius = 30;
    [self.contentView addSubview:iconButton];
    iconButton.backgroundColor = [UIColor redColor];
    self.iconButton = iconButton;
    
    /** 勋章 */
    UIImageView *medalView = [[UIImageView alloc] init];
    [self.contentView addSubview:medalView];
#warning 测试数据
    medalView.image = [UIImage imageNamed:@"grade"];
    self.medalView = medalView;
    
    /** 姓名 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = JXNameFont;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 驾校 */
    UILabel *schoolLabel = [[UILabel alloc] init];
    schoolLabel.font = JXSchoolFont;
    [self.contentView addSubview:schoolLabel];
    self.schoolLabel = schoolLabel;
    
    /** 距离 */
    UIButton *distanceView = [[UIButton alloc] init];
    [distanceView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    distanceView.titleLabel.font = JXDistanceFont;
    distanceView.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0);
    distanceView.titleLabel.textAlignment = NSTextAlignmentRight;
    distanceView.enabled = NO;
    [distanceView setImage:[UIImage imageNamed:@"distance_gray"] forState:UIControlStateNormal];
    [self.contentView addSubview:distanceView];
    self.distanceView = distanceView;
    
    /** 教师等级 */
    UILabel *rankLabel = [[UILabel alloc] init];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.textColor = [UIColor whiteColor];
    rankLabel.backgroundColor = JXColor(60, 187, 231);
    rankLabel.font = JXSignFont;
    [self.contentView addSubview:rankLabel];
    self.rankLabel = rankLabel;
    
    /** 工作年限 */
    UILabel *workYearLabel = [[UILabel alloc] init];
    workYearLabel.textAlignment = NSTextAlignmentCenter;
    workYearLabel.textColor = [UIColor whiteColor];
    workYearLabel.backgroundColor = JXColor(60, 187, 231);
    workYearLabel.font = JXSignFont;
    [self.contentView addSubview:workYearLabel];
    self.workYearLabel = workYearLabel;
    
    /** 教授类别 */
    UILabel *teachTypeLabel = [[UILabel alloc] init];
    teachTypeLabel.textAlignment = NSTextAlignmentCenter;
    teachTypeLabel.textColor = [UIColor whiteColor];
    teachTypeLabel.backgroundColor = JXColor(60, 187, 231);
    teachTypeLabel.font = JXSignFont;
    [self.contentView addSubview:teachTypeLabel];
    self.teachTypeLabel= teachTypeLabel;
    
    /** 学费 */
    UILabel *feeLabel = [[UILabel alloc] init];
    feeLabel.font = JXFeeFont;
    feeLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:feeLabel];
    self.feeLabel = feeLabel;
    
    /** 分割线 */
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = JXColor(229, 229, 229);
    [self.contentView addSubview:separatorView];
    
    MASAttachKeys(self.contentView, iconButton, medalView, nameLabel, schoolLabel, distanceView, rankLabel, workYearLabel, teachTypeLabel, feeLabel);
    
    [iconButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(margin);
        make.top.offset(margin);
        make.bottom.offset(- margin);
        make.width.equalTo(iconButton.height);
        make.right.equalTo(nameLabel.left).offset(-margin);
    }];
    
    [medalView makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(13);
        make.height.offset(18.33);
        make.bottom.right.equalTo(iconButton);
    }];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconButton.right).offset(margin);
        make.bottom.equalTo(iconButton.centerY);
        make.right.equalTo(schoolLabel.left).offset(-margin);
    }];
    
    [schoolLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.right).offset(margin);
        make.bottom.equalTo(nameLabel);
    }];
    
    [rankLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.bottom).offset(margin);
        make.left.equalTo(nameLabel);
        make.right.equalTo(workYearLabel.left).offset(-margin);
        make.width.offset(JXSignLabelW);
    }];
    
    [workYearLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rankLabel);
        make.left.equalTo(rankLabel.right).offset(margin);
        make.right.equalTo(teachTypeLabel.left).offset(-margin);
        make.width.offset(JXSignLabelW);
    }];
    
    [teachTypeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(workYearLabel);
        make.left.equalTo(workYearLabel.right).offset(margin);
        make.width.offset(JXSignLabelW);
    }];
    
    [distanceView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(schoolLabel);
        make.right.offset(-margin);
        make.width.offset(60);
        make.height.offset(20);
    }];
    
    [feeLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(distanceView).priorityLow();
        make.right.equalTo(distanceView);
        make.top.equalTo(teachTypeLabel);
    }];
    
    [separatorView makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.equalTo(nameLabel);
        make.right.equalTo(feeLabel);
        make.bottom.offset(0);
    }];
}

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
    self.nameLabel.text = teacher.name;
    self.schoolLabel.text = teacher.school;
    [self.distanceView setTitle:@"3.6km" forState:UIControlStateNormal];
    self.rankLabel.text = [NSString stringWithFormat:@"%zd级", teacher.rank];
    self.workYearLabel.text = [NSString stringWithFormat:@"%zd年", teacher.workYear];
    self.teachTypeLabel.text = teacher.teachType;
    self.feeLabel.text = [NSString stringWithFormat:@"￥%zd", (int)teacher.fee];
}

@end
