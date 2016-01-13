//
//  JXAccount.h
//  JMXMiJia
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 mac. All rights reserved.
//  账号模型

typedef enum {
    JXAccountSexFemale = 0, // 女性
    JXAccountSexMale        // 男性
} JXAccountSex;

#import <Foundation/Foundation.h>

@interface JXAccount : NSObject <NSCoding>
/** 手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 真实姓名 */
@property (nonatomic, copy) NSString *realName;
/** 推荐人手机号 */
@property (nonatomic, copy) NSString *rMobile;
/** 性别 */
@property (nonatomic, assign) JXAccountSex sex;
/** pushToken */
@property (nonatomic, copy) NSString *deviceToken;
@end
