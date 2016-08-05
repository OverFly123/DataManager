//
//  SDLUserInfoViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/5.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLUserInfoViewController.h"
#import "UIButton+BackgroundColor.h"
#import "SDLNickNameViewController.h"


static NSString *settingCellID = @"settingCellID";

@interface SDLUserInfoViewController ()<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIImageView *headImage;

@end

@implementation SDLUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人设置";
    self.view.backgroundColor = WArcColor;
    [self initData];
    [self createTableView];
    
}
#pragma mark - 初始化数据源
- (void)initData{
    self.dataArr = @[
                         @{
                             @"title":@"昵称",
                             @"class":[SDLNickNameViewController class]
                             },
                         @{
                             @"title":@"性别",
                             @"class":[UIViewController class]
                             },
                         @{
                             @"title":@"出生日期",
                             @"class":[UIViewController class]
                             },
                         @{
                             @"title":@"所在地",
                             @"class":[UIViewController class]
                             }
                     ];
}
#pragma mark -创建TableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户头像"]];
    [headerView addSubview:self.headImage];
    [self.headImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editAvatar)];
    tableView.tableHeaderView = headerView;
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(@100);
    }];
    [self.headImage addGestureRecognizer:tap];
    
    
    
    //底部退出登录按钮
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
    UIButton *loginOffButton = [[UIButton alloc]init];
    [loginOffButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOffButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginOffButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.127 blue:0.955 alpha:1.000] forState:UIControlStateNormal];
    [loginOffButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [footerView addSubview:loginOffButton];
    tableView.tableFooterView = footerView;
    
    
    [loginOffButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@48);
        make.centerY.equalTo(@0);
    }];
    [loginOffButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        [SDLUserModel loginOff];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:settingCellID];
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellID];
    
    cell.textLabel.text = [self.dataArr[indexPath.section]objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:15 weight:-0.15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *cellInfo = [self.dataArr objectAtIndex:indexPath.section];
    NSLog(@"%@",cellInfo);
    UIViewController *nextVC = [[[cellInfo objectForKey:@"class"] alloc]init];
    
    [self.navigationController pushViewController:nextVC animated:YES];
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark -加上点击事件
- (void)editAvatar{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"%ld",buttonIndex);
    if(buttonIndex == 0){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        //从图片图库选择
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置代理,处理图片选择完成的回调
        imagePicker.delegate = self;
        
        //支持裁剪
        imagePicker.allowsEditing = YES;
        
        //将图片选择控制器弹出
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }else if(buttonIndex == 1){
        
    }else{
        
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //在代理方法中，要先将控制器隐藏
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //将图片信息取出
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //1.将头像设置为图片
    [self.headImage setImage:editedImage];
    //2.将图片压缩上传
    //无损压缩
//    NSData *imageData = UIImagePNGRepresentation(editedImage);
    
    //有损压缩 一般我们取计算得到的图片文件过大 都会用有损压缩
    //压缩质量 0-1之间的数 越小 压缩的越厉害
    NSData *imageData = UIImageJPEGRepresentation(editedImage, 0.9);
    //上传
    NSDictionary *parameters = @{
                                 @"service":@"UserInfo.UpdateAvatar",
                                 @"uid":[SDLUserModel shareUser].ID
                                 };
    [AFNetworkTool uploadImageData:imageData andParameters:parameters completeBlock:^(BOOL success, id result) {
        if(success){
            NSLog(@"%@",result);
        }else{
            NSLog(@"%@",result);
        }
    }];
    
    NSLog(@"%@",info);
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
