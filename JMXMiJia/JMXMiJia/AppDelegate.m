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
#import <CoreMotion/CoreMotion.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate ()

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation AppDelegate {
    BOOL _isFullScreen;
}

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
    [self.window makeKeyAndVisible];
    
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
    
    // 初始化智能键盘
    [self setupIQKeyboardManager];
    
    [JXNotificationCenter addObserver:self selector:@selector(willEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    
    [JXNotificationCenter addObserver:self selector:@selector(willExitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
    return YES;
}
     
 - (void)willEnterFullScreen:(NSNotification *)notification
 {
     _isFullScreen = YES;
 }
 
 - (void)willExitFullScreen:(NSNotification *)notification
 {
     _isFullScreen = NO;
 }

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    if ([NSStringFromClass([[[window subviews]lastObject] class]) isEqualToString:@"UITransitionView"]) {
//        return UIInterfaceOrientationMaskAll;
//        //优酷 土豆  乐视  已经测试可以
//    }
//    return UIInterfaceOrientationMaskPortrait;
    
    if (_isFullScreen) {
        return UIInterfaceOrientationMaskPortrait |  UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

/**
 *  初始化智能键盘
 */
- (void)setupIQKeyboardManager {
    IQKeyboardManager *keyboard = [IQKeyboardManager sharedManager];
    keyboard.toolbarDoneBarButtonItemText = @"完成";
    keyboard.toolbarTintColor = [UIColor grayColor];
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

- (CMMotionManager *)motionManager {
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [self.motionManager startDeviceMotionUpdates];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    [self.motionManager stopDeviceMotionUpdates];
}

- (UIDeviceOrientation)realDeviceOrientation{
    CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    if (fabs(y) >= fabs(x))    {
        if (y >= 0)
            return UIDeviceOrientationPortraitUpsideDown;
        else
            return UIDeviceOrientationPortrait;
    }
    else
    {
        if (x >= 0)
            return UIDeviceOrientationLandscapeRight;
        else
            return UIDeviceOrientationLandscapeLeft;
    }
}

@end
