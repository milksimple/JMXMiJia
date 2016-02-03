//
//  JXSearchParas.h
//  JMXMiJia
//
//  Created by mac on 16/1/27.
//  Copyright © 2016年 mac. All rights reserved.
//  搜索筛选参数

/*
 注意：此模型所有属性必须为字符串
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface JXSearchParas : NSObject
/** 手机 */
@property (nonatomic, copy) NSString *mobile;
/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 从第几条数据开始 */
@property (nonatomic, copy) NSString *start;
/** 要得到多少条数据 */
@property (nonatomic, copy) NSString *count;
/** 经度 */
@property (nonatomic, copy) NSString *lon;
/** 纬度 */
@property (nonatomic, copy) NSString *lat;
/** 搜索关键词 */
@property (nonatomic, copy) NSString *keyword;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 所在驾校 */
@property (nonatomic, copy) NSString *school;
/** 教师等级,代表多少颗星 */
@property (nonatomic, copy) NSString *star;
/** 教练星级费用 */
@property (nonatomic, assign) NSInteger starFee;
/** 星级教练代称，如:五星教练 */
@property (nonatomic, copy) NSString *starName;
@end
