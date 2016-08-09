//
//  SDLClockView.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/9.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLClockView.h"


@interface SDLClockView ()

//时针
@property(nonatomic,strong) CAShapeLayer *hourShape;
//分针
@property(nonatomic,strong) CAShapeLayer *minuteShape;
//秒针
@property(nonatomic,strong) CAShapeLayer *secondShape;

//表盘
@property(nonatomic,strong) CAShapeLayer *clockShape;

@end



@implementation SDLClockView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUpLayers];
        [self setUpTimes];
    }
    return self;
}

- (void)setUpLayers{
    //先画表盘
    //表盘的属性
    self.clockShape = [CAShapeLayer layer];
    self.clockShape.lineWidth = 2.0f;
    self.clockShape.strokeColor = [UIColor blackColor].CGColor;
    self.clockShape.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.clockShape];
    
    UIBezierPath *clockPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width/2];
    self.clockShape.path = clockPath.CGPath;
    
    //再画时针
    self.hourShape = [CAShapeLayer layer];
    self.hourShape.lineWidth = 4.0f;
    self.hourShape.strokeColor = WArcColor.CGColor;
    //是这个 layer的锚点
    self.hourShape.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    UIBezierPath *hourPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, -self.frame.size.height/2 + 20, 3, self.frame.size.width/2-20)];
    self.hourShape.path = hourPath.CGPath;
    [self.layer addSublayer:self.hourShape];
    
    //设置分针
    self.minuteShape = [CAShapeLayer layer];
    self.minuteShape.lineWidth = 3.0f;
    self.minuteShape.strokeColor = WArcColor.CGColor;
    self.minuteShape.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    UIBezierPath *minPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, -self.frame.size.height/2 + 15, 2, self.frame.size.width/2-15)];
    self.minuteShape.path = minPath.CGPath;
    [self.layer addSublayer:self.minuteShape];
    
    
    //设置秒针
    self.secondShape = [CAShapeLayer layer];
    self.secondShape.lineWidth = 1.0f;
    self.secondShape.strokeColor = WArcColor.CGColor;
    self.secondShape.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    UIBezierPath *secondPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, -self.frame.size.height/2+5, 1, self.frame.size.width/2-5)];
    self.secondShape.path = secondPath.CGPath;
    [self.layer addSublayer:self.secondShape];
    
}
#pragma mark -添加定时器
- (void)setUpTimes{
    //有一个毫秒级的定时器 每秒钟固定会调用60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshTime)];
    //如果我们设置了一个 CADisplayLink  必须要将它加入到某个runloop 才能生效
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}
#pragma mark -定时器的实现方法
- (void)refreshTime{
    //获取当前的事件 设置我们的指针指向的位置
    NSDate *currentDate = [NSDate date];
    //要取得当前的时分秒
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //日期组成
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:currentDate];
    //取出之后 将时分秒转换为角度 并将指针选装
    [self.hourShape setAffineTransform:CGAffineTransformMakeRotation(components.hour/12.0 * 2*M_PI)];
    [self.minuteShape setAffineTransform:CGAffineTransformMakeRotation(components.minute/60.0*2*M_PI)];
    [self.secondShape setAffineTransform:CGAffineTransformMakeRotation(components.second/60.0 * 2 *M_PI)];
    
    
    
    
}




































/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
