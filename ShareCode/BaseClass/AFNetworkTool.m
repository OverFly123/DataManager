//
//  AFNetworkTool.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/2.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "AFNetworkTool.h"
#import <AFNetworking.h>

@implementation AFNetworkTool

//为了防止应用频繁获取网络数据的时候 创建的sessionManager过多 会大量消耗手机资源 我们最好封装为一个单例,获取网络数据只用到一个对象
+(AFHTTPSessionManager *)sharedManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //用BaseUrl生成sessionManager 就相当于告诉AFNetworking 以后我们请求数据 就是从这个服务器 那么就会把这个服务器的地址缓存起来
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://www.1000phone.tk"]];
        //设置请求的超时时间 设置请求的参数的编码方式
        //请求的序列号
        manager.requestSerializer.timeoutInterval = 30.0;
        
        
        //返回的序列号
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //设置请求头
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"http/json", @"text/html" ,@"text/xml", @"application/json", nil];
    });
    return manager;
}


+ (void)getDataWithPath:(NSString *)path andParameters:(NSDictionary *)parameter completeBlock:(void (^)(BOOL success, id result))complete{
    [[self sharedManager] POST:@"" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSNumber *serviceCode = [responseObject objectForKey:@"ret"];
        if([serviceCode isEqualToNumber:@200]){
            //证明没有服务错误
            NSDictionary *retData = [responseObject objectForKey:@"data"];
            NSNumber *dataCode = [retData objectForKey:@"code"];
            if([dataCode isEqualToNumber:@0]){
                //证明返回的数据没有错
                NSDictionary *userInfo = [retData objectForKey:@"data"];
                NSLog(@"----%@",userInfo);
                if(complete){
                    complete(YES,userInfo);
                }
                
            }else{
                NSString *dataMessage = [retData objectForKey:@"msg"];
                NSLog(@"%@",dataMessage);
                if(complete){
                    complete(NO,dataMessage);
                }
            }
        }else{
            //错误
            NSString *serviceMessage = [responseObject objectForKey:@"msg"];
            NSLog(@"-----%@",serviceMessage);
            if(complete){
                complete(NO,serviceMessage);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
    

}

@end