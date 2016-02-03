//
//  JXDetailFooterView.m
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXDetailFooterView.h"

@implementation JXDetailFooterView

+ (instancetype)footerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXDetailFooterView" owner:nil options:nil].lastObject;
}

+ (CGFloat)footerHeight {
    return 110;
}
- (IBAction)signup:(UIButton *)sender {
    if (self.signupButtonClickedAction) {
        self.signupButtonClickedAction();
    }
}

- (IBAction)call:(UIButton *)sender {
    if (self.callButtonClickedAction) {
        self.callButtonClickedAction();
    }
}

@end
