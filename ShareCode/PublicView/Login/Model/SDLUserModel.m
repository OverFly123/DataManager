//
//  SDLUserModel.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLUserModel.h"

@implementation SDLUserModel
+ (BOOL)isLogin{
    //如果这个单例ID存在 就是登陆
    return [self shareUser].ID;
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
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if([key isEqualToString:@"id"]){
//        self.ID = value;
//    }
//}


@end
