//
//  JXOptionalFee.h
//  JMXMiJia
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//  可选费用

#import <Foundation/Foundation.h>

@interface JXOptionalFee : NSObject
/** 费用名称 */
@property (nonatomic, copy) NSString *feeName;
/** 费用 */
@property (nonatomic, assign) NSInteger fee;
/** 份数 */
@property (nonatomic, assign) NSInteger copies;

@end
