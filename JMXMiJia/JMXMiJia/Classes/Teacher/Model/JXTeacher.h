//
//  JXTeacher.h
//  JMXMiJia
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 mac. All rights reserved.
//

/*
typedef enum {
    JXTeacherTeachTypeA1,
    JXTeacherTeachTypeA2,
    JXTeacherTeachTypeB1,
    JXTeacherTeachTypeB2,
    JXTeacherTeachTypeC1,
    JXTeacherTeachTypeC2
} JXTeacherTeachType;
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface JXTeacher : NSObject
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 所在驾校 */
@property (nonatomic, copy) NSString *school;
/** 评分等级,代表多少颗星 */
@property (nonatomic, assign) NSUInteger grade;
/** 教师等级 */
@property (nonatomic, assign) NSUInteger rank;
/** 当前位置 */
@property (nonatomic, strong)  CLLocation *location;
/** 学费 */
@property (nonatomic, assign) float fee;
/** 工作年限 */
@property (nonatomic, assign) NSInteger workYear;
/** 学车类别,比如“C1” */
@property (nonatomic, assign) NSString *teachType;

@end
