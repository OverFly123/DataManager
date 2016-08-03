//
//  SDLUserModel.h
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDLUserModel : NSObject

//通常都将用户当做一个model来看待 那么用户是否登录 就需要我们封装一个方法 因为在我们的程序整个生命周期内 很可能只会创建一个用户对象 用类方法就可以
+ (BOOL)isLogin;

@end
