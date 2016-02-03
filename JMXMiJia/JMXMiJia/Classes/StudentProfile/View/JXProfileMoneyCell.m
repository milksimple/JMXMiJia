//
//  JXProfileMoneyCell.m
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileMoneyCell.h"
#import <Masonry.h>

@implementation JXProfileMoneyCell

+ (instancetype)moneyCell {
    return [[NSBundle mainBundle] loadNibNamed:@"JXProfileMoneyCell" owner:nil options:nil].lastObject;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
