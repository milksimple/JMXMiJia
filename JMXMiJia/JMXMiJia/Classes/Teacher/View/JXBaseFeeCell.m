//
//  JXBaseFeeCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXBaseFeeCell.h"

@implementation JXBaseFeeCell

static NSString * const JXBaseFeeID = @"baseFeeCell";

+ (instancetype)baseFeeCell {
    return [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:JXBaseFeeID];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return JXBaseFeeID;
}

@end
