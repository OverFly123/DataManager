//
//  SDLPublicViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLPublicViewController.h"
#import "SDLUserModel.h"
#import "SDLLoginViewController.h"
#import "SDLMyViewController.h"


@interface SDLPublicViewController ()

@end

@implementation SDLPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将所有的控制器按照MVC的思想配置 并且封装起来
    [self setUpViewController];
    
    //当用户没有登陆的时候 需要弹出登录界面
    //设置界面显示样式
    [self setUpAppearance];
}
#pragma mark -设置界面显示样式
- (void)setUpAppearance{
    UITabBar *appearance = [UITabBar appearance];
    //背景颜色
    //[appearance setBarTintColor:[UIColor greenColor]];
    //前景颜色(视图上条目的颜色)
    [appearance setTintColor:[UIColor colorWithRed:0.464 green:0.271 blue:0.781 alpha:1.000]];
    [[UITextField appearance] setTintColor:[UIColor colorWithRed:1.000 green:0.296 blue:0.915 alpha:1.000]];
}
#pragma mark -判断用户是否登录
- (void)viewDidAppear:(BOOL)animated{
    //要在生命周期方法中调用父类的方法
    [super viewDidAppear:animated];
    //当用户没有登录的时候 需要弹出登录界面
    if([SDLUserModel isLogin]){
        
    }else{
        [self showLoginViewController];
    }
    
    
}
#pragma mark -创建登录界面
- (void)showLoginViewController{
    //用模态视图弹出登录控制器
    SDLLoginViewController *loginVC = [[SDLLoginViewController alloc]init];
    //一般在使用模态视图时，都会用当行控制器将视图包装一下
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

#pragma mark -使用MVC创建控制器 用数据控制现实的界面
- (void)setUpViewController{
    //如何使用MVC
    NSArray *controllerInfoArr = @[
                                   //数组里面每一个条目都是一个字典 里面配置了所有控制器显示的效果和类型
                                   @{
                                       @"class":[UIViewController class],
                                       @"title": @"首页",
                                       @"icon": @"按钮主页",
                                       },
                                   @{
                                       @"class":[UIViewController class],
                                       @"title": @"消息",
                                       @"icon": @"按钮消息",
                                       },
                                   @{
                                       @"class":[UIViewController class],
                                       @"title": @"分享",
                                       @"icon": @"按钮分享",
                                       },
                                   @{
                                       @"class":[SDLMyViewController class],
                                       @"title": @"我的",
                                       @"icon": @"按钮我的",
                                       },
                                 ];
    NSMutableArray *controllerArrM = [NSMutableArray arrayWithCapacity:controllerInfoArr.count];
    //数组的枚举遍历方法
    [controllerInfoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //这里直接拿遍历 block传过来的字典 取出其中的控制器类型 然后创建一个控制器
        UIViewController *controller = [[[obj objectForKey:@"class"]alloc]init];
        controller.title = [obj objectForKey:@"title"];
        controller.tabBarItem = [[UITabBarItem alloc]initWithTitle:[obj objectForKey:@"title"] image:[UIImage imageNamed:[obj objectForKey:@"icon"]] tag:0];
        
        //再创建一个导航控制器 装入刚才创建的控制器
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
        //需要将导航控制器装入到数组中
        [controllerArrM addObject:nav];
        
    }];
    //配置控制器数组
    self.viewControllers = controllerArrM;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
