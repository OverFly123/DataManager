//
//  SDLCircleView.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/9.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLCircleView.h"


@interface SDLCircleView ()

// 路径 绘制圆圈
@property(nonatomic,strong) UIBezierPath *circlePath;

//我们将路径画到这个layer
@property(nonatomic,strong) CAShapeLayer *circleLayer;

@end


@implementation SDLCircleView

//- (void)drawRect:(CGRect)rect{
//    //1.创建上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //2.创建一个贝塞尔曲线 第二个参数是半径
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width/2];
//    //设置线条的属性
//    bezierPath.lineWidth = 2.0;
//    CGContextSetStrokeColorWithColor(context, WArcColor.CGColor);
//    
//    
//    
//    //3.把曲线加入到上下文中
//    CGContextAddPath(context, bezierPath.CGPath);
//    //4
//    CGContextDrawPath(context, kCGPathFillStroke);
//}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //圆形的路径
        self.circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height) cornerRadius:frame.size.width/2];
        
        //shapeLayer
        self.circleLayer = [[CAShapeLayer alloc]init];
        
        [self.layer addSublayer:self.circleLayer];
        //设置相关属性
        [self.circleLayer setLineWidth:2.0f];
        [self.circleLayer setStrokeColor:WArcColor.CGColor];
        //IOS 在绘制这个layer时  会按照这个路径来
        [self.circleLayer setPath:self.circlePath.CGPath];
        
        [self.circleLayer setFillColor:[UIColor whiteColor].CGColor];
        //用shapeLayer 可以很方便的设置线条的进度
        [self.circleLayer setStrokeStart:0.0];
        
        [self.circleLayer setLineCap:kCALineCapRound];
        
        //[self.circleLayer setStrokeEnd:0.5];
        //写一个定时器
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeProgress:) userInfo:nil repeats:YES];
        
    }
    return self;
}
#pragma mark -定时器的实现方法
- (void)changeProgress:(NSTimer *)timer{
    self.progress = WArcNum(100)/100.0;
    self.circleLayer.strokeColor = WArcColor.CGColor;
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    //CALayer 默认是带动画的
    
    [self.circleLayer setStrokeEnd:progress];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
