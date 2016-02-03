//
//  JXSearchParas.m
//  JMXMiJia
//
//  Created by mac on 16/1/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXSearchParas.h"
#import "JXAccount.h"
#import "JXAccountTool.h"

@implementation JXSearchParas

- (NSString *)mobile {
    JXAccount *account = [JXAccountTool account];
    return account.mobile;
}

- (NSString *)password {
    JXAccount *account = [JXAccountTool account];
    return account.password;
}

- (void)setStar:(NSString *)star {
    _star = star;
    
    switch ([star integerValue]) {
        case 0: // 普通教练费用
            self.starFee = 0;
            break;
            
        case 1: // 一星教练费用
            self.starFee = 100;
            break;
            
        case 2:
            self.starFee = 200;
            break;
            
        case 3:
            self.starFee = 300;
            break;
            
        case 4:
            self.starFee = 400;
            break;
            
        case 5:
            self.starFee = 500;
            break;
            
        default:
            break;
    }
}
@end
