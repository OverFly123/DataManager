//
//  SDLRegisterViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLRegisterViewController.h"
#import "UIControl+ActionBlocks.h"
#import "NSTimer+Blocks.h"
#import "NSTimer+Addition.h"

#import <Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SMS_SDK/SMSSDK.h>
#import "UIButton+BackgroundColor.h"
#import "TAlertView.h"

@interface SDLRegisterViewController ()

//写成属性 可以方便的监控变化
@property(nonatomic,strong)NSNumber *waitTime;

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation SDLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor colorWithWhite:0.760 alpha:1.000];
    [self createUI];
}
#pragma mark -创建UI
- (void)createUI{
    
    //创建手机号码输入框 密码输入框 登录按钮
    UITextField *phoneField = [[UITextField alloc]init];
    phoneField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneField];
    phoneField.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    UITextField *passwordField = [[UITextField alloc]init];
    passwordField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordField];
    passwordField.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    
    phoneField.placeholder = @"请输入手机号";
    passwordField.placeholder = @"请输入密码";
    
    passwordField.secureTextEntry = YES;
    
    UIImageView *phoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户图标"]];
    
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *passLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码图标"]];
    
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 48)];
    UIView *passwordLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 48)];
    [phoneLeft addSubview:phoneLeftImage];
    [passwordLeft addSubview:passLeftImage];
    
    
    
    phoneField.leftView = phoneLeft;
    passwordField.leftView = passwordLeft;
    
    
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //让视图居中
        make.center.equalTo(@0);
    }];
    [passLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //让视图居中
        make.center.equalTo(@0);
    }];
    
    //边框
    phoneField.layer.borderColor = [UIColor grayColor].CGColor;
    phoneField.layer.borderWidth = 0.5;
    passwordField.layer.borderColor = [UIColor grayColor].CGColor;
    passwordField.layer.borderWidth = 0.5;
    
    //手写输入框的布局
    //不管写布局的时候 添加的所有约束必须能够唯一确定这个视图的位置和大小
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@48);
        make.top.equalTo(@120);
        make.left.right.equalTo(@0);
        //因为Masonry 在实现的时候 充分考虑到写约束的时候越简单 越好 所以引入了链式写法
    }];
    
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@48);
        make.top.equalTo(phoneField.mas_bottom);
    }];
    
    //填写验证码文本框
    UITextField *CAPTCHAText = [[UITextField alloc]init];
    CAPTCHAText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:CAPTCHAText];
    CAPTCHAText.placeholder = @"请输入验证码";
    CAPTCHAText.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    UIView *CAPTCHALeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 48)];
    UIImageView *CAPTCHAImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [CAPTCHALeft addSubview:CAPTCHAImage];
    [CAPTCHAImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    CAPTCHAText.leftView = CAPTCHALeft;
    CAPTCHAText.leftViewMode = UITextFieldViewModeAlways;
    [CAPTCHAText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(passwordField.mas_bottom).offset(10);
        make.height.equalTo(@48);
    }];
    CAPTCHAText.layer.borderColor = [UIColor grayColor].CGColor;
    CAPTCHAText.layer.borderWidth = 0.5;
    
    
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
    CAPTCHAText.rightView = rightView;
    CAPTCHAText.rightViewMode = UITextFieldViewModeAlways;
    
    //需要短信验证等待时间
    //1.为了节省成本 一般开发中用地三方短信提供商做发送验证码功能 一条6-8分钱
    //2.为了用户体验
    //需求 :点击发送验证码 按钮变为不可用 如果发送成功 按钮不可用 按钮上面显示时间倒计时 如果失败，将按钮设置为可用，提示发送失败 当倒计时结束的时候 将按钮设置为可用（还要验证手机号是否符合规则）
    //我们可以设置一个初值为60的变量 发送验证码的按钮在0-60的时候 按钮不可用 监听这个数字的变化 
    [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        //直接进入读秒
        self.waitTime = @60;
        
        
        //发送验证码
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if(error){
                //NSLog(@"error%@",error);
                //如果失败 等待时间变为-1
                self.waitTime = @-1;
            }else{
                NSLog(@"获取验证码成功");
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^{
                    
                    self.waitTime = [NSNumber numberWithInteger:self.waitTime.integerValue - 1];
                    
                } repeats:YES];
            }
        }];
    }];
    //用ARC监控数据的变化 显示画面
    [RACObserve(self, waitTime) subscribeNext:^(NSNumber *waitTime) {
        if(waitTime.integerValue <= 0){
            [self.timer invalidate];
            self.timer = nil;
            [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }else{
            [rightButton setTitle:[NSString stringWithFormat:@"等待%@秒",waitTime] forState:UIControlStateNormal];
        }
    }];
    
    
    
    //给等待时间赋初值为-1
    self.waitTime = @-1;
    //获取验证码按钮默认是不可点击
    rightButton.enabled = NO;
    //可以直接将某个信号处理的返回结果设置为某个对象的属性值
    // RAC(rightButton,enabled) = [RACSignal combineLatest:<#(id<NSFastEnumeration>)#> reduce:<#^id(void)reduceBlock#>]
    //combineLatest 一堆信号的集合
    RAC(rightButton,enabled) = [RACSignal combineLatest:@[phoneField.rac_textSignal,RACObserve(self, waitTime)] reduce:^(NSString *phone,NSNumber *waitTime){
        return @(phone.length >= 11 && waitTime.integerValue<=0);
    }];
    
    
    
    
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [loginButton titleLabel].font = [UIFont systemFontOfSize:15];
    [loginButton setFrame:CGRectMake(0, 320, self.view.bounds.size.width, 40)];
    [self.view addSubview:loginButton];
    //按钮不同状态显示不同的背景颜色
    //1.不同的状态设置不同的图片 1.普通状态 2.高亮状态 3.不可用状态
    //2.在不同状态的事件下面设置按钮的背景颜色
    //3.使用封装好的分类方法，简单方便
    [loginButton setBackgroundColor:[UIColor colorWithRed:0.417 green:1.000 blue:0.416 alpha:1.000] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [loginButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [loginButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        [SMSSDK commitVerificationCode:CAPTCHAText.text phoneNumber:phoneField.text zone:@"86" result:^(NSError *error) {
            if(error){
                [self createAlert:@"您输入的验证码错误，请重新输入!"];
            }else{
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }];
    }];
    //当我们不用antuLayout 的时候，如何去让视图自适应
    //autoResizing
    //登录按钮的宽度和左边距保持跟父控件相对位置不变
    loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleLeftMargin;
    
    //设置用户账号输入框只能输入数字
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    //ReactiveCocoa 可以代替 delegate target action 通知 KVO 等IOS开发里面的数据传递方式
    //RAC 使用的是信号流的方式来处理数据，无论是按钮，点击事件还是输入框事件还是网络数据获取都可以被当做'信号'被看待
    //可以观测某个信号的改变 进行相应的操作
    //RAC 还可以将多个信号合并处理 过滤某些信号、自定义一些信号 所以比较强大
    //RAC 帮我们实现了很多系统自带的信号,文本框的变化。。按钮的点击
    //我们去订阅这些信号 当信号一旦发生变化 就会通知我们
    [phoneField.rac_textSignal subscribeNext:^(NSString *phone) {
        if(phone.length >= 11){
            //当用户输入的手机号超过11为 直接将密码框设置为第一响应者
            [passwordField becomeFirstResponder];
            if(phone.length > 11){
                phoneField.text = [phone substringToIndex:11];
            }
        }
    }];
    
    
    
    
    

    //RAC可以讲信号和处理写到一起 做项目的时候就不用来回找了
    loginButton.enabled = NO;
    RAC(loginButton,enabled) = [RACSignal combineLatest:@[phoneField.rac_textSignal,passwordField.rac_textSignal,CAPTCHAText.rac_textSignal] reduce:^(NSString *phone,NSString *password, NSString *CAPTCHA ){
        return @(phone.length >=11 && password.length>=6 && CAPTCHA.length ==4);
    }];
    
}
#pragma mark -计时器


- (void)createAlert:(NSString *)str{
    NSArray *arr = @[@"确定"];
    TAlertView *alert = [[TAlertView alloc]initWithTitle:@"温馨提示" message:str buttons:arr andCallBack:^(TAlertView *alertView, NSInteger buttonIndex) {
        
    }];
    [self systemAlert];
    [alert show];
}

- (void)systemAlert{
    TAlertView *appearance = [TAlertView appearance];
    appearance.alertBackgroundColor     = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    appearance.titleFont                = [UIFont fontWithName:@"Baskerville" size:22];
    appearance.messageColor             = [UIColor whiteColor];
    appearance.messageFont              = [UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:14];
    appearance.buttonsTextColor         = [UIColor whiteColor];
    appearance.buttonsFont              = [UIFont fontWithName:@"Baskerville-Bold" size:16];
    appearance.separatorsLinesColor     = [UIColor grayColor];
    appearance.tapToCloseFont           = [UIFont fontWithName:@"Baskerville" size:10];
    appearance.tapToCloseColor          = [UIColor grayColor];
    appearance.tapToCloseText           = @"Touch to close";
    [appearance setTitleColor:[UIColor orangeColor] forAlertViewStyle:TAlertViewStyleError];
    [appearance setDefaultTitle:@"Error" forAlertViewStyle:TAlertViewStyleError];
    [appearance setTitleColor:[UIColor whiteColor] forAlertViewStyle:TAlertViewStyleNeutral];
    
}
//用户需求
//1.账号输入框 用户只可以输入数字  2.当用户输入11个数字后不可以在继续输入 3.当账号输入框小于11个数字 那么获取验证码按钮作为灰色不可点  4.当账号为11个数字 密码大于等于6个长度 验证码为4个数字 注册按钮可用
//1.设置键盘样式  2.可以再代理方法里判断，如果输入框长度大于11 返回no 3.在代理方法里面处理  4.



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
