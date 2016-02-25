//
//  JXMessageTableViewCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/24.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^JXMessageTableViewCellDidClickedAccessoryButtonAction)();

#import <UIKit/UIKit.h>


@interface JXMessageTableViewCell : UITableViewCell

- (CGFloat)rowHeight;
/** 是否展开 */
@property (nonatomic, assign) BOOL expland;

@property (nonatomic, copy) JXMessageTableViewCellDidClickedAccessoryButtonAction corverButtonClickedAction;
@end
