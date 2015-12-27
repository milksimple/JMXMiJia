//
//  AppDelegate.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "JXTabBarController.h"
#import <BBBadgeBarButtonItem.h>
#import "UIView+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    JXTabBarController *tabBarController = [[JXTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    // 信件按钮
    UIButton *letterButton = [[UIButton alloc] init];
    [letterButton setImage:[UIImage imageNamed:@"nav_letter"] forState:UIControlStateNormal];
    BBBadgeBarButtonItem *letterItem = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:letterButton];
    letterItem.badgeOriginX = 20;
    letterItem.badgeOriginY = -10;
        letterItem.badgeMinSize = -10;
    letterItem.badgeValue = @"1";
    
    UIView *customView = letterItem.customView;
    CGFloat customViewW = 26;
    CGFloat customViewH = 17.3;
    CGFloat customViewX = JXScreenW - customViewW - JXScreenW * 0.05;
    CGFloat customViewY = 20 + (44 - customViewH) * 0.5;
    customView.frame = CGRectMake(customViewX, customViewY, customViewW, customViewH);
    [self.window addSubview:customView];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
