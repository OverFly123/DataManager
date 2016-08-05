//
//  SDLUserModel.h
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDLUserModel : NSObject

@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *nikename;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *name;


//通常都将用户当做一个model来看待 那么用户是否登录 就需要我们封装一个方法 因为在我们的程序整个生命周期内 很可能只会创建一个用户对象 用类方法就可以


+ (BOOL)isLogin;


+ (SDLUserModel *)shareUser;


//封装给外部两个方法
//登录
+ (void)loginWithInfo:(NSDictionary *)userInfo;
//登出
+ (void)loginOff;


@end
