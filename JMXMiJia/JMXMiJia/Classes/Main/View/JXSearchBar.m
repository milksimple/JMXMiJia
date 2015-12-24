//
//  JXSearchBar.m
//  JMXMiJia
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXSearchBar.h"
#import <Masonry.h>

@interface JXSearchBar()

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *searchButton;

@end

@implementation JXSearchBar

static CGFloat const margin = 10;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JXColor(246, 246, 246);
        [self setup];
    }
    return self;
}

- (void)setup {
    WS(weakSelf);
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magnifier"]];
    left.contentMode = UIViewContentModeCenter;
    left.frame = CGRectMake(0, 0, 40, 19);
    textField.leftView = left;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:textField];
    self.textField = textField;
    textField.placeholder = @"输入查找教练";
    
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.layer.borderWidth = 1;
    [self addSubview:searchButton];
    self.searchButton = searchButton;
    
    MASAttachKeys(self, textField, searchButton);
    
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.width).multipliedBy(0.7);
        make.height.offset(44);
        make.left.offset(margin);
//        make.top.offset(margin);
//        make.bottom.offset(-margin);
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(searchButton.left).offset(-margin * 0.5);
    }];
    
    [searchButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(textField);
        make.left.equalTo(textField.right).offset(margin * 0.5);
        make.right.offset(-margin);
    }];
}

@end
