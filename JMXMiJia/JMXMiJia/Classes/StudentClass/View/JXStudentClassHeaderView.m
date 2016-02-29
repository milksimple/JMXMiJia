//
//  JXStudentClassHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentClassHeaderView.h"
#import "JXStudentProgress.h"

@interface JXStudentClassHeaderView()
/** 阶段名 */
@property (weak, nonatomic) IBOutlet UILabel *phraseNameLabel;
/** 未开始/完成 此阶段 */
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
/** 结束时间label */
@property (weak, nonatomic) IBOutlet UILabel *finishDateLabel;

@end

@implementation JXStudentClassHeaderView

+ (instancetype)header {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentClassHeaderView class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)headerHeight {
    return 50;
}

/**
 *  遮盖按钮被点击了
 */
- (IBAction)corverButtonClicked:(id)sender {
    // 调用外面定义好的block
    if (self.headerViewClickedAction) {
        self.headerViewClickedAction();
    }
}

- (void)setProgress:(JXStudentProgress *)progress {
    _progress = progress;
    
    self.phraseNameLabel.text = JXPhraseName[progress.phrase];
    self.completeLabel.text = progress.complete ? @"合格":@"在学";
}

@end
