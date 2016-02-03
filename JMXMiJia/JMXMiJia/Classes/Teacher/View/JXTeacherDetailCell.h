//
//  JXTeacherDetailCell.h
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//  教师详情页的cell

#import <UIKit/UIKit.h>

@class JXTeacher;
@interface JXTeacherDetailCell : UITableViewCell

@property (nonatomic, strong) JXTeacher *teacher;

@property (nonatomic, assign) CGFloat rowHeight;
@end
