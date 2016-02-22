//
//  JXStudentProgressDetailCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXStudentProgress;

@interface JXStudentProgressDetailCell : UITableViewCell

@property (nonatomic, strong) JXStudentProgress *progress;

+ (NSString *)reuseIdentifier;

+ (instancetype)cell;

+ (CGFloat)rowHeight;
@end
