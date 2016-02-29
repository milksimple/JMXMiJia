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
    
    switch (progress.phrase) {
        case 0:
            self.phraseNameLabel.text = @"科目一";
            break;
            
        case 1:
            self.phraseNameLabel.text = @"科目二";
            break;
            
        case 2:
            self.phraseNameLabel.text = @"科目三";
            break;
            
        case 3:
            self.phraseNameLabel.text = @"科目四";
            break;
            
        default:
            break;
    }
    
    switch (progress.phraseStatus) {
        case JXStudentProgressPhraseStatusNotStart:
            self.completeLabel.text = @"未开始";
            self.finishDateLabel.text = nil;
            break;
            
        case JXStudentProgressPhraseStatusStuding:
            self.completeLabel.text = @"在学";
            self.finishDateLabel.text = nil;
            break;
            
        case JXStudentProgressPhraseStatusComplete:
            self.completeLabel.text = @"合格";
            self.finishDateLabel.text = progress.finishTime;
            break;
            
        default:
            break;
    }
}


@end
