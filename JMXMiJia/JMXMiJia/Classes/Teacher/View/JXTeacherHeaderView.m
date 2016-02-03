//
//  JXTeacherHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherHeaderView.h"

@implementation JXTeacherHeaderView

- (IBAction)order:(UIButton *)sender {
    if (self.orderButtonClickedAction) {
        self.orderButtonClickedAction();
    }
}

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXTeacherHeaderView" owner:nil options:nil].firstObject;
}

+ (CGFloat)headerHeight {
    return 54;
}
@end
