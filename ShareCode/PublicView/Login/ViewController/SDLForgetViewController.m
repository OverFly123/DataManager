//
//  SDLForgetViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLForgetViewController.h"
#import <Masonry.h>

#import "UIButton+BackgroundColor.h"

@interface SDLForgetViewController ()

@end

@implementation SDLForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor colorWithWhite:0.888 alpha:1.000];
    
    [self crerateUI];
}
#pragma mark - 创建UI
- (void)crerateUI{
    UITextField *phoneText = [[UITextField alloc]init];
    phoneText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.height.equalTo(@48);
    }];
    phoneText.placeholder = @"请输入手机号码或邮箱";
    phoneText.font = [UIFont systemFontOfSize:15 weight:-0.15];
    UIView *phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 48)];
    UIImageView *phoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机邮箱图标"]];
    [phoneLeft addSubview:phoneLeftImage];
    phoneText.layer.borderColor = [UIColor grayColor].CGColor;
    phoneText.layer.borderWidth = 0.5;
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    phoneText.leftView = phoneLeft;
    phoneText.leftViewMode = UITextFieldViewModeAlways;
   
    
    
    
    UITextField *passwordText = [[UITextField alloc]init];
    passwordText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordText];
    passwordText.placeholder = @"请输入验证码";
    passwordText.font = [UIFont systemFontOfSize:15 weight:-0.15];

    UIView *passLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 48)];
    UIImageView *passLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [passLeft addSubview:passLeftImage];
    [passLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    passwordText.leftView = passLeft;
    passwordText.leftViewMode = UITextFieldViewModeAlways;
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(phoneText.mas_bottom);
        make.height.equalTo(@48);
    }];
    passwordText.layer.borderColor = [UIColor grayColor].CGColor;
    passwordText.layer.borderWidth = 0.5;
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [rightButton setTitle:@"获取验证码"  forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [rightButton titleLabel].font = [UIFont systemFontOfSize:12 weight:-0.15];
    [rightButton layer].borderColor = [UIColor lightGrayColor].CGColor;
    [rightButton layer].borderWidth = 1.0f;
    [rightButton layer].cornerRadius = 4.0f;
    [rightButton layer].masksToBounds = YES;
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 72, 48)];
    [rightView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.top.equalTo(@8);
        make.left.equalTo(@4);
    }];
    passwordText.rightView = rightView;
    passwordText.rightViewMode = UITextFieldViewModeAlways;
    
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
