//
//  SDLCircleViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/9.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLCircleViewController.h"
#import "SDLCircleView.h"
#import "SDLClockView.h"


@interface SDLCircleViewController ()

@end

@implementation SDLCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    SDLCircleView *view1 = [[SDLCircleView alloc]initWithFrame:CGRectMake(80, 100, 100, 100)];
    [self.view addSubview:view1];
    
    
    SDLClockView *view2 = [[SDLClockView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    [self.view addSubview:view2];
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
