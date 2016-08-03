//
//  AppDelegate.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/2.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "AppDelegate.h"
#import "SDLPublicViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //g当我们吧 main关联 去掉 打开APP会只展示一个黑色的window
    //一般情况下  为了防止appdelegate方法里面添加的东西过多 显得程序混乱 我们都会将不同的模块封装起来
    [self createRootViewController];
    [self createSMSSDK];
    return YES;
}
#pragma mark -配置短信验证
- (void)createSMSSDK{
    [SMSSDK registerApp:@"158f5193e0d79" withSecret:@"2673c9cb90b6a4e42afadef257c283db"];
}

- (void)createRootViewController{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[SDLPublicViewController alloc]init];
    [self.window makeKeyAndVisible];
    
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
