//
//  SDLNickNameViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/5.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLNickNameViewController.h"

@interface SDLNickNameViewController ()

@end

@implementation SDLNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更改姓名";
    self.view.backgroundColor = WArcColor;
    
    UITextField *nickName = [[UITextField alloc]init];
    [self.view addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@80);
        make.height.equalTo(@48);
    }];
    nickName.backgroundColor = [UIColor whiteColor];
    nickName.placeholder = @"不得超过15个字母或字符";
    nickName.returnKeyType = UIReturnKeyDone;
    [nickName handleControlEvents:UIControlEventEditingDidEnd withBlock:^(id weakSender) {
        
        //在这里将姓名修改  调用修改用户信息的接口
        NSDictionary *parameters = @{
                                     @"service":@"UserInfo.UpdateInfo",
                                     @"uid":[SDLUserModel shareUser].ID,
                                     @"nickname":nickName.text
                                     };
        [AFNetworkTool getDataWithPath:QFAppBaseURL andParameters:parameters completeBlock:^(BOOL success, id result) {
            if(success){
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"上传失败");
            }
        }];
        
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
