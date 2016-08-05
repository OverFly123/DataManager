//
//  SDLUserModel.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLUserModel.h"


//储存用户信息的Key
static NSString *userInfoKey = @"UserInfoKey";
static NSString *userStatus = @"UserStatus";

@implementation SDLUserModel
+ (BOOL)isLogin{
    //如果这个单例ID存在 就是登陆
    return [[NSUserDefaults standardUserDefaults] boolForKey:userStatus];
}
//当某个类（或者分类）一旦加载，就会调用这个方法
+ (void)load{
    //判断用户以前是否登录  如果登录 就像存储的用户信息取出 并且设置单例
    if([self isLogin]){
        [self loginWithInfo:[[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey]];
    }
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"ID":@"id"
             };
}
+ (SDLUserModel *)shareUser{
    static SDLUserModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[SDLUserModel alloc]init];
    });
    return user;
}
//把用户的登录状态保存起来  还需要保存登陆的信息，id，token, 如果对于数量较小的信息 可以直接存储到NSUserDefault
//关于用户登录或者退出登录这样的时间 都会用通知来管理  一般都是一对多的关系
+ (void)loginWithInfo:(NSDictionary *)userInfo{
    //1.用户登录完成 更新用户信息
    [[self shareUser] yy_modelSetWithDictionary:userInfo];
    //2.通知所有的地方 用户登录成功
    [[NSNotificationCenter defaultCenter]postNotificationName:WLogInSuccess object:nil];
    //将用户的登录状态和信息存到本地
    [self saveUserInfo:userInfo];
}
+ (void)saveUserInfo:(NSDictionary *)userInfo{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //用 setObject:forkey: 存储用户信息
    [userDefault setObject:[[self shareUser] yy_modelToJSONObject] forKey:userInfoKey];
    //用setbool:forkey 存储用户状态
    [userDefault setBool:userInfo ? YES:NO forKey:userStatus];
    
    //同步
    [userDefault synchronize];
    
}
+ (void)loginOff{
    //1.把用户model对象属性置空
    //2.发送用户登出的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:WLogOffSuccess object:nil];
    [self saveUserInfo:nil];
    
}












@end
