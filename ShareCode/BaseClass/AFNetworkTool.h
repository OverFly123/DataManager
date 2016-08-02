//
//  AFNetworkTool.h
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/2.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetworkTool : NSObject

//需求分析
//我们一般在请求网络数据时需要什么
//网址 参数对
//请求到的数据
//网络请求是异步操作 所以获取到的数据不能直接返回 要用block回调
//这个里面没有失败的回调 我们有可能需要在外面处理失败后的动作
//这个类 仅仅只是作为一个帮助类 不需要具体的对象去做什么事
//如果需要请求失败的回调
//我们可以封装成像AFNetworking那样成功失败分别走两个block 成功的block返回的是获取到的数据 失败的block返回的是失败的原因  我们也可以封装到一个block 返回成功或者失败的具体的数据
//我们在做公司项目的时候 接口地址的都是统一的



+ (void)getDataWithPath:(NSString *)path andParameters:(NSDictionary *)parameter completeBlock:(void(^)(BOOL success, id result))complete ;

@end
