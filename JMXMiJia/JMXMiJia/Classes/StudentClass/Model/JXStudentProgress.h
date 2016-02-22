//
//  JXStudentProgress.h
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//  学生的课堂进度

#import <Foundation/Foundation.h>

@interface JXStudentProgress : NSObject
/** 阶段 */
@property (nonatomic, assign) NSInteger phrase;

/** 完成状态 */
@property (nonatomic, assign) BOOL complete;
/** 开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 完成时间 */
@property (nonatomic, copy) NSString *finishTime;
@end
