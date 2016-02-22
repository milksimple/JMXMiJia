//
//  JXStudentProgressDetailCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentProgressDetailCell.h"
#import "JXStudentProgress.h"

@interface JXStudentProgressDetailCell()

@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStatusLabel;

@end

@implementation JXStudentProgressDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressDetailCell class]) owner:nil options:nil].lastObject;
}

+ (NSString *)reuseIdentifier {
    return @"studentProgressDetailCell";
}

- (void)setProgress:(JXStudentProgress *)progress {
    _progress = progress;
    
    
}

+ (CGFloat)rowHeight {
    return 50;
}

@end
