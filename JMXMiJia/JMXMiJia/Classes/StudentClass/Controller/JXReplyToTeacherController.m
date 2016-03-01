//
//  JXReplyToTeacherController.m
//  JMXMiJia
//
//  Created by 张盼盼 on 16/3/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXReplyToTeacherController.h"
#import "UIView+JXExtension.h"
#import "JXTextView.h"

@interface JXReplyToTeacherController ()

@end

@implementation JXReplyToTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"回评教练";
    self.view.backgroundColor = JXGlobalBgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setup];
}

- (void)setup {
    JXTextView *replyTextView = [[JXTextView alloc] init];
    CGFloat replyW = JXScreenW * 0.9;
    CGFloat replyH = replyW * 0.4;
    CGFloat replyX = (JXScreenW - replyW) * 0.5;
    CGFloat replyY = 64 + 20;
    replyTextView.frame = CGRectMake(replyX, replyY, replyW, replyH);
    replyTextView.textAlignment = NSTextAlignmentJustified;
    replyTextView.font = [UIFont systemFontOfSize:17];
    replyTextView.placeholder = @"点击评论您的教练。(教练本人不可见喔)";
    [self.view addSubview:replyTextView];
}
@end
