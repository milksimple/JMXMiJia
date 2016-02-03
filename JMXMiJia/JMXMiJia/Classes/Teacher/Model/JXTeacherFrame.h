//
//  JXTeacherFrame.h
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//  教师模型的frame模型

#import <Foundation/Foundation.h>

@class JXTeacher;
@interface JXTeacherFrame : NSObject

@property (nonatomic, strong) JXTeacher *teacher;

/** 姓名frame */
@property (nonatomic, assign) CGRect nameF;
/** 所在驾校frame */
@property (nonatomic, assign) CGRect schoolF;
/** 评分等级frame,代表多少颗星 */
@property (nonatomic, assign) CGRect gradeF;
/** 教师等级frame */
@property (nonatomic, assign) CGRect rankF;
/** 当前位置frame */
@property (nonatomic, assign)  CGRect locationF;
/** 学费frame */
@property (nonatomic, assign) CGRect feeF;
/** 工作年限frame */
@property (nonatomic, assign) CGRect workYearF;
/** 学车类别frame,比如“C1” */
@property (nonatomic, assign) CGRect teachTypeF;
/** 个人介绍frame */
@property (nonatomic, assign) CGRect introductionF;
/** 报名人数frame */
@property (nonatomic, assign) CGRect signupCountF;

@end
