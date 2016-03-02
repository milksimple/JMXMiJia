//
//  JXProfileMoneyCell.m
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileMoneyCell.h"
#import <Masonry.h>
#import "JXAccount.h"

@interface JXProfileMoneyCell()
/** 推荐的人数 */
@property (weak, nonatomic) IBOutlet UILabel *recommendCountLabel;
/** 红包钱数 */
@property (weak, nonatomic) IBOutlet UILabel *redBagLabel;

@end

@implementation JXProfileMoneyCell

+ (instancetype)moneyCell {
    return [[NSBundle mainBundle] loadNibNamed:@"JXProfileMoneyCell" owner:nil options:nil].lastObject;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAccount:(JXAccount *)account {
    _account = account;
    
    self.recommendCountLabel.text =  [NSString stringWithFormat:@"%zd", account.count];
    self.redBagLabel.text = [NSString stringWithFormat:@"%.2f元", account.balance];
}

@end
