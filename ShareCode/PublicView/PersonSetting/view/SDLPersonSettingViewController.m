//
//  SDLPersonSettingViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/5.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLPersonSettingViewController.h"
#import "SDLUserInfoViewController.h"


#define SETTINGCELLID  @"settingCellID"

static NSString *settingCellID = @"settingCellID";

@interface SDLPersonSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation SDLPersonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithWhite:0.762 alpha:1.000];
    //初始化数据
    [self initData];
    //设置界面
    [self createTableView];
}

#pragma mark -初始化数据
- (void)initData{
    //用MVC的方式去屑tableview 让tableview根据我们提前设置好的数据去展示就OK
    
    self.dataArr = @[
                     @[
                         @{
                             @"title":@"个人信息",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@"arrow"
                             }
                         ],
                     @[
                         @{
                             @"title":@"允许查看我的分享",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@"switch"
                             },
                         @{
                             @"title":@"允许查看我的下载",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@"switch"
                             },
                         @{
                             @"title":@"任何人允许添加我为好友",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@"switch"
                             },
                         ],
                     @[
                         @{
                             @"title":@"保存到本地",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@"arrow"
                             },
                         @{
                             @"title":@"账号绑定",
                             @"subTitle":@"QQ977416809",
                             @"cellType":@"arrow"
                             },
                         ],
                     @[
                         @{
                             @"title":@"清除缓存",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@""
                             },
                         @{
                             @"title":@"关于我们",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@"arrow"
                             },
                         @{
                             @"title":@"用户反馈",
                             @"subTitle":@"哈哈,真傻",
                             @"cellType":@"arrow"
                             },
                         
                         ]
                     ];
    
}

#pragma mark -创建界面
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor colorWithRed:0.895 green:0.825 blue:0.941 alpha:1.000];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:settingCellID];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
  
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellID];
    NSDictionary *cellInfo = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = [cellInfo objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:15 weight:-0.15];
    NSString *cellType = [cellInfo objectForKey:@"cellType"];
    if([cellType isEqualToString:@"arrow"]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if([cellType isEqualToString:@"switch"]){
        cell.accessoryView = [[UISwitch alloc]init];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0){
        SDLUserInfoViewController *userInfoVC = [[SDLUserInfoViewController alloc]init];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
    
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
