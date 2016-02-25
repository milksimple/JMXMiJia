//
//  JXStudentProgressFooter.m
//  JMXMiJia
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentProgressFooter.h"

@implementation JXStudentProgressFooter

+ (instancetype)footer {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressFooter class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)footerHeight {
    return 70;
}

@end
