//
//  AppDelegate.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//  13116296826 // 测试账号
//  13708803633  111111  进度测试接口
//  18213857463

#import "AppDelegate.h"
#import "JXTabBarController.h"
#import <BBBadgeBarButtonItem.h>
#import "UIView+Extension.h"
#import "JXAccountTool.h"
#import "JXLoginViewController.h"
#import <IQKeyboardManager.h>
#import <SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }

    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 判断之前是否登录过
    JXAccount *account = [JXAccountTool account];
    if (account.hasLogin) { // 之前登录过
        JXTabBarController *tabBarController = [[JXTabBarController alloc] init];
        self.window.rootViewController = tabBarController;
    }
    else {
        JXLoginViewController *loginVC = [[JXLoginViewController alloc] init];
        self.window.rootViewController = loginVC;
    }
    
    [self.window makeKeyAndVisible];
    // 初始化智能键盘
    [self setupIQKeyboardManager];
    
    return YES;
}

/**
 *  初始化智能键盘
 */
- (void)setupIQKeyboardManager {
    IQKeyboardManager *keyboard = [IQKeyboardManager sharedManager];
    keyboard.enable = YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    JXAccount *account = [JXAccountTool account];
    NSString *pushToken = [[[[deviceToken description]
                             
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    account.pushToken = pushToken;
    [JXAccountTool saveAccount:account];
    
    JXLog(@"deviceToken = %@", deviceToken);
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    JXLog(@"userInfo - %@", userInfo);
//    application.applicationIconBadgeNumber = 0;
}

@end
