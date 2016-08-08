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
    
    //封装监测新版本
    [self checkNewVersion];
    //3DTouch
    //1.可以作为我们app的快捷键直接打开某个深层次的界面 2.可以预览新界面的样式  3.可以直接通过快捷操作 来哦实现不进入到某个控制器 却调用他的一些方法 其实就相当于给我们的APP添加了很多交互的方式
    [self setUpShortKeys];
    
    return YES;
}
#pragma mark -实现3DTouch
- (void)setUpShortKeys{
    
    UIApplicationShortcutItem *itme1 = [[UIApplicationShortcutItem alloc]initWithType:@"type1" localizedTitle:@"按钮一" localizedSubtitle:@"我是小图标" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    UIApplicationShortcutItem *itme2 = [[UIApplicationShortcutItem alloc]initWithType:@"type2" localizedTitle:@"按钮二" localizedSubtitle:@"我是小图标" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
    UIApplicationShortcutItem *itme3 = [[UIApplicationShortcutItem alloc]initWithType:@"type3" localizedTitle:@"按钮三" localizedSubtitle:@"我是小图标" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo:nil];
    
    //动态的在app内修改
    //<#(NSArray<UIApplicationShortcutItem *> * _Nullable)#>
    [[UIApplication sharedApplication]setShortcutItems:@[itme1,itme2,itme3]];
    //如果使用这种方式 我们可以随时在app运行的时候 动态修改我们的快捷方式 我们还可以在info.plist文件中先指定几个快捷键(优先级最低) 这样的话我们的app从appStore一安装 不用运行 就可以直接使用快捷键
}
#pragma mark -3DTouch里面按钮点击事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //当用户通过点击桌面上图标的快捷按钮进入到app 会先调用这个方法 我们可以在这里做相应的处理
    
    NSString *type = shortcutItem.type;
    //type是可以标记某个item的方式之一
    if([type isEqualToString:@"type2"]){
        //如果是选择按钮2  那么久执行这个方法  进入第四个界面
        if([type isEqualToString:@"type2"]){
            [(UITabBarController *)[self window].rootViewController setSelectedIndex:3];
        }
    }
    
    
}
#pragma mark -监测新版本
- (void)checkNewVersion{
    
    //虽说APPStore不允许在应用检测更新 但是为了用户能够尽早的体验新版本 这个工作还是要做的
    //1.不能再界面上直接展示 2.我们要保证在送审期间不能弹出新版本提示(有服务器控制)
    
    NSDictionary *paras = @{
                            @"service":@"Version.GetLatestVersion"
                            };
    [AFNetworkTool getDataWithPath:nil andParameters:paras completeBlock:^(BOOL success, id result) {
       //取出最新的版本号
        NSInteger latestVersion = [[result objectForKey:@"version"]integerValue ];
        //取出当前的版本号
        //通过info.plist取当前版本号
        NSInteger nowVersion = [[[[NSBundle mainBundle]infoDictionary]objectForKey:kCFBundleVersionKey]integerValue];
        //对比 如果当前版本比新版本低 就弹出警示框
        if(nowVersion<latestVersion){
            NSArray *arr = @[@"去更新",@"取消"];
            TAlertView *alert = [[TAlertView alloc]initWithTitle:@"您有新的版本" message:[result objectForKey:@"content"] buttons:arr andCallBack:^(TAlertView *alertView, NSInteger buttonIndex) {
                switch (buttonIndex) {
                    case 0:{
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://ituns.apple.com/app/id984365130"]];
                    }
                        break;
                    default:
                        break;
                }
            }];
            [alert show];
        }
        
    }];
    
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
