//
//  ViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/2.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkTool.h"





@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *dict = @{@"service":@"UserInfo.GetInfo", @"uid":@"1"};

    [AFNetworkTool getDataWithPath:@"https://www.1000phone.tk" andParameters:dict completeBlock:^(BOOL success, id result) {
        if(success){
            NSLog(@"用户信息--%@",result);
        }else{
            NSLog(@"失败原因--%@",result);
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
