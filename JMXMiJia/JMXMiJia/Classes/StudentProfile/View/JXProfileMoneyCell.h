//
//  JXProfileMoneyCell.h
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXAccount;

@interface JXProfileMoneyCell : UITableViewCell

@property (nonatomic, strong) JXAccount *account;

+ (instancetype)moneyCell;

@end
