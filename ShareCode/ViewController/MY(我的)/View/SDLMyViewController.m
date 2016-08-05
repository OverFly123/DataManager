//
//  SDLMyViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/5.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLMyViewController.h"

#import "SDLPersonSettingViewController.h"

@interface SDLMyViewController ()
/**
 *  如果一个界面被加入到父视图上面 就代表已经被强引用了 所以不需要再去强引用也不会被释放掉 所以我们用 xib 拖控件的时候 默认是weak引用
    平时我们写的时候也可以尽量写成weak引用  防止特殊情况发生循环引用
 */
@property(nonatomic,weak)UIScrollView *scrollView;
//内容视图 加载scrollView上面 所有其他视图都加在这个视图上面
@property(nonatomic,weak)UIView *contentView;

@end

@implementation SDLMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithRed:0.901 green:0.248 blue:0.870 alpha:1.000];
    
    //整个界面在一个 scrollView上
    [self createScorllView];
    //配置界面上方的样式
    [self createHeaderView];
    
}

#pragma mark -创建ScorllView
- (void)createScorllView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = WArcColor;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
   
    self.scrollView = scrollView;
    //只有当scrollView内容大于宽高才可以有滚动效果
    UIView *contentView = [[UIView alloc]init];
    [scrollView addSubview:contentView];
    contentView.backgroundColor = WArcColor;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view);
//        //offset是偏移量 可以为正 为负
//        make.height.greaterThanOrEqualTo(self.view).offset(1);
        make.edges.equalTo(scrollView);
        make.width.equalTo(self.view);
        make.height.greaterThanOrEqualTo(self.view).offset(1);
        make.bottom.equalTo(scrollView);
        
    }];
    self.contentView = contentView;
    
     //如果控制器有scrollview 并且有导航条或者tabbar 系统会默认将scrollview的上部留有64的高度 下部有49高度 防止被挡住  但是在实际做项目的时候 我们为了方便手动管理 会把这个特性去掉 然后自己写
    self.automaticallyAdjustsScrollViewInsets = NO;
    //手动设置滚动指示器的insets
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0);
    //手动设置scrollview的insets 防止内容被覆盖
    scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    
    

}
#pragma mark -创建界面上面的样式
- (void)createHeaderView {
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景图片"]];
    backImageView.userInteractionEnabled = YES; //打开用户交互
    [self.contentView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@16);
        make.height.equalTo(@140);
    }];
    //用户头像
    UIImageView *headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头像"]];
    [backImageView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.width.height.equalTo(@58);
    }];
    //用户昵称
    UILabel *nickNameLable = [[UILabel alloc]init];
    nickNameLable.font = [UIFont systemFontOfSize:16 weight:-0.15];
    [backImageView addSubview:nickNameLable];
    nickNameLable.textColor = [UIColor whiteColor];
    [nickNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(10);
        make.top.equalTo(@16);
        make.width.equalTo(@200);
    }];
    //用户邮箱
    UILabel *emailLable = [[UILabel alloc]init];
    [backImageView addSubview:emailLable];
    emailLable.font = [UIFont systemFontOfSize:14 weight:-0.15];
    [emailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickNameLable);
        make.top.equalTo(nickNameLable.mas_bottom).offset(4);
        make.width.equalTo(@200);
    }];
    
    //设置按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backImageView addSubview:settingButton];
    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingButton titleLabel].font = [UIFont systemFontOfSize:15 weight:-0.15];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.centerY.equalTo(@0);
        make.width.equalTo(@48);
        make.height.equalTo(@32);
    }];
    //先完成 设置 并且完善用户资料
    [settingButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        SDLPersonSettingViewController *personSettingVC = [[SDLPersonSettingViewController alloc]init];
        personSettingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personSettingVC animated:YES];
        
        
        
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
