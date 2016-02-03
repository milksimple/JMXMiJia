//
//  JXTeacherHeaderView.h
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^TeacherHeaderClickedButtonAction)();

#import <UIKit/UIKit.h>

@interface JXTeacherHeaderView : UIView

@property (nonatomic, copy) TeacherHeaderClickedButtonAction orderButtonClickedAction;

+ (instancetype)headerView;

+ (CGFloat)headerHeight;
@end
