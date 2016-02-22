//
//  JXStudentProgressCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//  学生课堂进度

#import <UIKit/UIKit.h>
@class JXStudentProgress;

@interface JXStudentProgressCell : UITableViewCell

+ (instancetype)cell;
/** 进度模型 */
@property (nonatomic, strong) NSArray *progresses;

+ (CGFloat)rowHeight;
@end
