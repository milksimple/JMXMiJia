//
//  JXProfileHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileHeaderView.h"
#import <Masonry.h>
#import "JXAccount.h"
#import "JXAccountTool.h"
#import <UIImageView+WebCache.h>

@interface JXProfileHeaderView()
@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *jiamiNOLabel;


@end

@implementation JXProfileHeaderView

static CGFloat const margin = 10;
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    UIImageView *iconView= [[UIImageView alloc] init];
    iconView.clipsToBounds = YES;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *jiamiNOLabel = [[UILabel alloc] init];
    jiamiNOLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:jiamiNOLabel];
    self.jiamiNOLabel = jiamiNOLabel;
    
    UIButton *profileInfoButton = [[UIButton alloc] init];
    [profileInfoButton addTarget:self action:@selector(profileInfoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    profileInfoButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [profileInfoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [profileInfoButton setTitle:@"个人资料" forState:UIControlStateNormal];
    [self addSubview:profileInfoButton];
    
    UIImageView *accessory = [[UIImageView alloc] init];
    accessory.image = [UIImage imageNamed:@"accessory_right"];
    [self addSubview:accessory];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(margin*2);
        make.bottom.offset(-margin*2);
        make.width.equalTo(iconView.height);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.right).offset(margin);
        make.bottom.equalTo(iconView.centerY);
        
    }];
    
    [jiamiNOLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.bottom);
        make.left.equalTo(nameLabel.left);
    }];
    
    [accessory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-margin);
        make.centerY.equalTo(self.centerY);
    }];
    
    [profileInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(accessory.left).offset(-margin);
    }];
}

- (void)setAccount:(JXAccount *)account {
    _account = account;
    
    if (account.photo.length == 0) {
        self.iconView.image = [UIImage imageNamed:@"ico_placeholder"];
    }
    else {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:account.photo] placeholderImage:[UIImage imageNamed:@"ico_placeholder"]];
    }
    
    self.nameLabel.text = account.name;
    self.jiamiNOLabel.text = [NSString stringWithFormat:@"驾米号:%@", account.mobile];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width * 0.5;
}

/**
 *  个人资料按钮被点击
 */
- (void)profileInfoButtonClicked {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(profileHeaderViewDidClickedProfileInfoButton)]) {
        [self.delegate profileHeaderViewDidClickedProfileInfoButton];
    }
}

@end
