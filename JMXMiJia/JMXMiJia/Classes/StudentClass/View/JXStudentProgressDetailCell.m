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
/** 圆点 */
@property (weak, nonatomic) IBOutlet UIView *pointView;
/** 科目名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 开始状态 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *bgButton;

@end

@implementation JXStudentProgressDetailCell

- (void)awakeFromNib {
    // Initialization code
#warning 测试数据
    self.classDetailLabel.text = @"\n--2015年01月10日 理论知识:4 实际操作:3\n\n--2015年01月10日 理论知识:4 实际操作:3\n\n--2015年01月10日 理论知识:4 实际操作:3\n";
    self.classDetailLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

//- (IBAction)corverButtonClicked:(UIButton *)sender {
//    // 调用外面定义好的block
//    if (self.corverButtonClickedAction) {
//        self.corverButtonClickedAction();
//    }
//}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressDetailCell class]) owner:nil options:nil].lastObject;
}

+ (NSString *)reuseIdentifier {
    return @"studentProgressDetailCell";
}


+ (CGFloat)rowHeight {
    return 44;;
}



@end
