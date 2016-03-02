//
//  JXStudentProgressFooter.h
//  JMXMiJia
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//  我的进度页面的footer

#import <UIKit/UIKit.h>

@protocol JXStudentProgressFooterDelegate <NSObject>

@optional
- (void)studentProgressFooterDidClickReplyButton;

@end

@interface JXStudentProgressFooter : UIView

+ (instancetype)footer;

+ (CGFloat)footerHeight;

@property (nonatomic, weak) id<JXStudentProgressFooterDelegate> delegate;
@end
