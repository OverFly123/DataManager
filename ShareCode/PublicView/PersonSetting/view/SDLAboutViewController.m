//
//  SDLAboutViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/8.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLAboutViewController.h"
#import <MessageUI/MessageUI.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@interface SDLAboutViewController ()<MFMessageComposeViewControllerDelegate>{
    CTCallCenter *_callCenter;
}

@end

@implementation SDLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //这个界面一般都是写死的 用XIB做最好 会包含APP的基本信息(版本，开发)，和联系方式
    //打电话和发短信功能
    self.title = @"关于我们";
    self.view.backgroundColor = WArcColor;
    
    [self createButton];
    //如何去监听用户打电话的状态,去做相应的处理
    CTCallCenter *callCenter = [[CTCallCenter alloc]init];
    
    [callCenter setCallEventHandler:^(CTCall * _Nonnull call) {
        //在这里根据不同的状态去做不同的处理
        NSLog(@"%@",[call callState]);
        //如果在这里有涉及到视图的修改 要主动跳到主线程去做
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.backgroundColor = WArcColor;
        });
    }];
    //我们现在用的ARC 如果对象不被引用会直接销毁掉，虽然直接写好了处理的block 但是callCenter是被释放了 应该将callCenter 当做成员变量
    
    _callCenter = callCenter;
}
#pragma mark -创建四个按钮布局
- (void)createButton{
    NSArray *titles = @[@"联系电话一",@"联系电话二",@"短信一",@"短信二"];
    
    UIButton *lastButton = nil;
    for (int i= 0; i<titles.count; i++) {
        //取出title 创建按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setBackgroundColor:WArcColor];
        [self.view addSubview:button];
        //我们用 masonry设置约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.centerX.equalTo(@0);
            make.height.equalTo(@48);
            make.top.equalTo(lastButton ? lastButton.mas_bottom:@0).offset(lastButton ? 16 : 80);
            
        }];
        lastButton = button;
        
        button.tag = i+ 10;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

#pragma mark -按钮的点击事件实现
- (void)tapButton:(UIButton *)button{
    switch (button.tag) {
        case 10:{
            //调用电话APP 直接打给某个号码 并且没有提示
            //打给王老师
            //没有提示 可能会造成APPStore拒绝我们的应用
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://18513017173"]];
        }
            break;
        case 11:{
            //我们可以用webView来打电话
            //这种方式，打完电话可以直接回答应用，
            //在拨出去之前会给用户一个提示
            UIWebView *webView = [[UIWebView alloc]init];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://15668031098"]]];
            [self.view addSubview:webView];
            
            //这里的webView最好用懒加载方式
            
        }
            break;
        case 12:{
            //用这种方式发短信，无法回到应用 无法指定消息内容 不能群发
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://15668031098"]];
        }
            break;
        case 13:{
            
            MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
            //用这种方式发短信可以自定义内容和群发
            //如果应用的用户有ipad 或iPod 这个适配一定要做
            
            if([MFMessageComposeViewController canSendText]){
                messageVC.body = @"青岛啤酒节,什么鬼";
                messageVC.recipients = @[@"15668031098",@"18513017173"];
                //设置代理
                messageVC.messageComposeDelegate = self;
                [self presentViewController:messageVC animated:YES completion:^{
                    
                }];
            }
        }
            break;
        default:
            break;
    }
    //一般的IOS APP直接应用传值都是使用这种方式 一个app一旦定义了紫镜子scheme 那么其他的app就可以直接打开 我们在appDelegate 中可以根据传来的不同参数执行不同的 功能
    //在iOS9之后 我们想要打开其他app 需要经过用户同意才可以 并且需要现在plist文件中配置好对方的app scheme
    //我们还可以通这种方式去手机用户手机上都安装了哪些APP
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tencent://"]];
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]];
    
}
#pragma mark -MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    //不管成功还是失败 先将控制器隐藏
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSLog(@"%d",result);
    //经过实践之后发现 群发的人数不要超过50人 否则会卡到跳转的时候
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
