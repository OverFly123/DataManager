//
//  SDLSuggertionViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/8.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLSuggertionViewController.h"

@interface SDLSuggertionViewController ()

@end

@implementation SDLSuggertionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"反馈";
    
    //我们一般这样做
    //1.有一个反馈入口,通常在设置界面 2.我们需要做一个求好评的弹框
    //如果用户点击给好评 我们就直接跳转到appStore应用界面，   如果用户给差评 直接让用户跳转到反馈界面 直接反馈给我们  吐过选择“以后再说” 就可以降低弹出求好评框的频率
    
    
    [self createUI];
}

#pragma mark -创建UI
- (void)createUI{
    
    UITextView *textView = [[UITextView alloc]init];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(@10);
        make.height.equalTo(@300);
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@30);
    }];
    
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
