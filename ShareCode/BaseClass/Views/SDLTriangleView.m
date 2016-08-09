//
//  SDLTriangleView.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/9.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLTriangleView.h"

@implementation SDLTriangleView

//如果想自定义视图的形状，需要重写 -(void)drawRect: 方法  我们在实现这个方法时 不用去调用父类方法    如果没有特殊需求 就千万不要调用父类方法    这个方法传入的rect参数  就是这个视图的bounds

- (void)drawRect:(CGRect)rect{
    
    
    [self.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    //Drawing code
    //1.在绘制之前 首先要获取到当前的图形上下文 (创建画布)
    //UIGraphicsGetCurrentContext()这个方法  可以再drawRect中使用  获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.设置画笔的参数
    
    CGContextSetLineWidth(context, 5.0f);    //设置线的宽度
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor); //设置线的颜色
    //给线条绘制阴影
    //第二个参数表示阴影的偏移量 是CGSIZE对象
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0, [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 1.0, 0, 0, 1); //设置填充颜色
    CGContextSetRGBStrokeColor(context, 0, 1.0, 0, 1); //设置笔触的颜色
    CGContextSetLineCap(context, kCGLineCapButt);    //设置顶点的样式
    CGContextSetLineJoin(context, kCGLineJoinBevel);   //设置连接点的样式
    
    
    
    
    
    
    
    //3.开始划线 首先找到一个起始点
    //先创建一条可变的线条(相当于画线的时候 先创建一条县 然后设置它的起始点和终点)
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, rect.size.width/2, 5);
    //在讲话比移动到终点 (在起点和终点画一条直线)
    //我们设置的点其实是笔触的中心点 所以有时需要减去画笔的粗细的一半
    CGPathAddLineToPoint(path, nil, 10, rect.size.height-10);
    //再画接下来的线
    CGPathAddLineToPoint(path, nil, rect.size.width-10, rect.size.height-10);
    //回到起始点  完成这个三角形
    CGPathAddLineToPoint(path, nil, rect.size.width/2, 5);
    
    
    
    
    //4.将线手动添加到画布上
    CGContextAddPath(context, path);
    //5.提交绘图  第二个参数是填充形式
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    
    
}




















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
