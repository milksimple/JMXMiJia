//
//  JXStudentScoreCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentScoreCell.h"

@implementation JXStudentScoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentScoreCell class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)rowHeight {
    return 100;
}

@end
