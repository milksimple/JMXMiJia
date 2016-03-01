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
@property (weak, nonatomic) IBOutlet UIButton *bgButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
/** 日期 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/** 理论知识 */
@property (weak, nonatomic) IBOutlet UILabel *theoryLabel;
/** 实际操作 */
@property (weak, nonatomic) IBOutlet UILabel *practiceLabel;

@end

@implementation JXStudentProgressDetailCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.containerView.backgroundColor = selected ? [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.3] : [UIColor whiteColor];
}

//- (IBAction)corverButtonClicked:(UIButton *)sender {
//    // 调用外面定义好的block
//    if (self.corverButtonClickedAction) {
//        self.corverButtonClickedAction();
//    }
//}

- (void)setComment:(JXToStudentComment *)comment {
    _comment = comment;
    
    self.dateLabel.text = comment.date;
    self.theoryLabel.text = [NSString stringWithFormat:@"理论知识:%zd", comment.starsA];
    self.practiceLabel.text = [NSString stringWithFormat:@"实际操作:%zd", comment.starsB];
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressDetailCell class]) owner:nil options:nil].lastObject;
}

+ (NSString *)reuseIdentifier {
    return @"studentProgressDetailCell";
}


+ (CGFloat)rowHeight {
    return 45;;
}



@end
