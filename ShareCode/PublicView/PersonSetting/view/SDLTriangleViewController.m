//
//  SDLTriangleViewController.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/9.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLTriangleViewController.h"
#import "SDLTriangleView.h"



@interface SDLTriangleViewController ()

@end

@implementation SDLTriangleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"核心绘图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    //给一个视图添加背景图片 默认是拉伸
    
    //self.view.layer.contents = (id)([UIImage imageNamed:@"button1"].CGImage);
    //可以将图片先转成color 在设置 默认是平铺
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon"]];
    
    SDLTriangleView *view1 = [[SDLTriangleView alloc]initWithFrame:CGRectMake(26, 80, 100, 100)];
    [self.view addSubview:view1];
    
    SDLTriangleView *view2 = [[SDLTriangleView alloc]initWithFrame:CGRectMake(200, 180, 160, 160)];
    [self.view addSubview:view2];
    
    SDLTriangleView *view3 = [[SDLTriangleView alloc]initWithFrame:CGRectMake(0, 280, 50, 50)];
    [self.view addSubview:view3];
    //截图  给某一个View截图
    [self saveScreenShortWith:view1];
    
    
    
    
}
#pragma mark -实现截图的方法
- (void)saveScreenShortWith:(UIView *)view{
    //先生成一张图片的画布
    //图片的大小  是否保留透明度  放大倍数
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    
    //IOS7以后
    if([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    }else{
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    //将图片保存起来
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
   
    UIImageWriteToSavedPhotosAlbum(screenShot,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //结束图片画布
    UIGraphicsEndImageContext();
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
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
