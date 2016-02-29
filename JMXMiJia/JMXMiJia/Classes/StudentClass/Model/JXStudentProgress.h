//
//  JXStudentProgress.h
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//  学生的课堂进度

typedef enum {
    JXStudentProgressPhraseStatusNotStart, // 未开始
    JXStudentProgressPhraseStatusStuding, // 在学
    JXStudentProgressPhraseStatusComplete // 完成
} JXStudentProgressPhraseStatus;

#import <Foundation/Foundation.h>

@interface JXStudentProgress : NSObject
/** 阶段 */
@property (nonatomic, assign) NSInteger phrase;
/** 进度阶段状态 */
@property (nonatomic, assign) JXStudentProgressPhraseStatus phraseStatus;
/** 完成状态 */
@property (nonatomic, assign) BOOL complete;
/** 完成时间 */
@property (nonatomic, copy) NSString *finishTime;
@end
