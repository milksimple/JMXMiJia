//
//  JXTeacherMovieCell.m
//  JMXMiJia
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherMovieCell.h"
#import "UIView+JXExtension.h"

@interface JXTeacherMovieCell()


@end

@implementation JXTeacherMovieCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 1.获取视频的URL
    NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4"];
    
    // 2.创建控制器
    MPMoviePlayerController *playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // 4.将View添加到控制器上
    [self.contentView addSubview:playerController.view];
    
    // 5.设置属性
    playerController.controlStyle = MPMovieControlStyleDefault;
    
    playerController.scalingMode = MPMovieScalingModeAspectFit;
    
    playerController.shouldAutoplay = NO;
    
    self.playerController = playerController;
    
    [playerController prepareToPlay];
}

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
//    self.playerController.contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", JXServerName, teacher.]];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
//    [self.playerController prepareToPlay];
}

+ (CGFloat)rowHeight {
    return JXScreenW * 9.0 / 16.0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat playerX = 20;
    CGFloat playerW = self.jx_width - 2 * playerX;
    CGFloat playerH = playerW * 9.0 / 16.0;
    CGFloat playerY = (self.jx_height - playerH) * 0.5;
    
    self.playerController.view.frame = CGRectMake(playerX, playerY, playerW, playerH);
}

@end
