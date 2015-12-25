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

static CGFloat const margin = 15;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JXColor(249, 249, 249);
        [self setup];
    }
    return self;
}

- (void)setup {
    
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
    [searchButton addTarget:self action:@selector(searchButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton setTitleColor:JXColor(200, 200, 200) forState:UIControlStateNormal];
    searchButton.layer.borderWidth = 1;
    searchButton.layer.borderColor = JXColor(239, 239, 239).CGColor;
    [self addSubview:searchButton];
    self.searchButton = searchButton;
}

/**
 *  搜索按钮被点击了
 */
- (void)searchButtonDidClicked {
    // 获得textfield中的内容
    NSString *searchContent = self.textField.text;
    if (searchContent) { // 内容不为空
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(searchBarButtonDidClickedWithSearchContent:)]) {
            [self.delegate searchBarButtonDidClickedWithSearchContent:searchContent];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WS(weakSelf);
    
    MASAttachKeys(self, self.textField, self.searchButton);
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.width).multipliedBy(0.65);
        make.left.offset(margin);
        make.top.offset(margin);
        make.bottom.offset(-margin);
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(self.searchButton.left).offset(-margin);
    }];
    
    [self.searchButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.textField);
        make.left.equalTo(self.textField.right).offset(margin);
        make.right.offset(-margin);
    }];
}

+ (CGFloat)height {
    return 64;
}

- (void)quitKeyboard {
    [self.textField resignFirstResponder];
}

@end
