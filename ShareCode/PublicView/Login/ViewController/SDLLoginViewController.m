//
//  SDLLoginViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/3.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLLoginViewController.h"
#import <Masonry.h>

#import "UIImage+Color.h"
#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"
#import "UIAlertView+Block.h"
#import "NSString+MD5.h"

#import "SDLForgetViewController.h"
#import "SDLRegisterViewController.h"
#import "SDLUserModel.h"

@interface SDLLoginViewController ()

@end

@implementation SDLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.769 alpha:1.000];
    self.title = @"登录";
    
    // 一般创建UI 都会写到ViewDidLoad
    //ViewDidLoad 是控制器的视图  已经加载完毕时候会自动调用的一个方法
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

    
    phoneField.placeholder = @"请输入邮箱或手机号";
    passwordField.placeholder = @"请输入密码";
    
    passwordField.secureTextEntry = YES;
    
    UIImageView *phoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户图标"]];
   
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *passLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码图标"]];
    
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 64)];
    UIView *passwordLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 64)];
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
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(@120);
        make.left.right.equalTo(@0);
        //因为Masonry 在实现的时候 充分考虑到写约束的时候越简单 越好 所以引入了链式写法
    }];
    
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phoneField.mas_bottom);
    }];
    
    
    //自定义Button一定要用工厂方法
    //忘记密码按钮
    UIButton *forgetPassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPassButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassButton titleLabel].font = [UIFont systemFontOfSize:14];
    [forgetPassButton setFrame:CGRectMake(self.view.frame.size.width-80, 250, 80, 64)];
    [self.view addSubview:forgetPassButton];
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
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
    
    //当我们不用antuLayout 的时候，如何去让视图自适应
    //autoResizing
    //登录按钮的宽度和左边距保持跟父控件相对位置不变
    loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleLeftMargin;
    
    //两个跳转界面
    [forgetPassButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    //将按钮的事件与按钮写到一块
    //1.
    [forgetPassButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        //把按钮的事件回调写到block里 便于在写界面的时候方便的加入控制事件
        SDLForgetViewController *forgetVC = [[SDLForgetViewController alloc]init];
        
        [self.navigationController pushViewController:forgetVC animated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(gotoRegister)];
    
    //
    [phoneField handleControlEvents:UIControlEventEditingChanged withBlock:^(id weakSender) {
        if(phoneField.text.length >=11){
            if(phoneField.text.length >11){
                phoneField.text = [phoneField.text substringToIndex:11];
            }
            [passwordField becomeFirstResponder];
        }
    }];
    RAC(loginButton,enabled) = [RACSignal combineLatest:@[phoneField.rac_textSignal,passwordField.rac_textSignal] reduce:^(NSString *phone , NSString *pass){
        return @(phone.length >= 11 && pass.length >=6);
    }];
    //登录
    [loginButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
       
        NSDictionary *parameters = @{
                                     @"service":@"User.Login",
                                     @"phone":phoneField.text,
                                     @"password":[passwordField.text md532BitUpper]
                                     };
       [AFNetworkTool getDataWithPath:nil andParameters:parameters completeBlock:^(BOOL success, id result) {
           if(success){
               NSLog(@"%@",result);
               //SDLUserModel *user = [SDLUserModel shareUser];
               //[user yy_modelSetWithDictionary:result];
               [SDLUserModel loginWithInfo:result];
               
               
               [self.navigationController dismissViewControllerAnimated:YES completion:nil];
           }else{
               [UIAlertView  alertWithCallBackBlock:nil title:@"温馨提示" message:result cancelButtonName:@"确定" otherButtonTitles:nil, nil];
           }
       }];
    }];
    
    
    
}
#pragma mark -注册页面
- (void)gotoRegister{
    SDLRegisterViewController *registerVC = [[SDLRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
