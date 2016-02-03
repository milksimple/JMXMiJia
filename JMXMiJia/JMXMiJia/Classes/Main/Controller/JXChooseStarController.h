//
//  JXChooseStarController.h
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//  筛选教师星级控制器

#import <UIKit/UIKit.h>

@protocol JXChooseStarControllerDelegate <NSObject>

@optional
- (void)chooseStarDidFinished:(NSString *)star;

@end

@interface JXChooseStarController : UITableViewController

@property (nonatomic, weak) id<JXChooseStarControllerDelegate> delegate;
/** 默认(上次)选中的星级 */
@property (nonatomic, copy) NSString *defaultStar;

@end
