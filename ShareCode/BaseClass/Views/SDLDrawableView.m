//
//  SDLDrawableView.m
//  ShareCode
//
//  Created by qianfeng_sdl on 16/8/9.
//  Copyright © 2016年 songdongliang_sdl. All rights reserved.
//

#import "SDLDrawableView.h"
@interface SDLDrawableView ()

//当前手指所在的点
@property(nonatomic,assign)CGPoint currentPoint;
//上一次手指所在的点
@property(nonatomic,assign)CGPoint prePoint;
//将路径保存起来
@property(nonatomic,assign)CGMutablePathRef path;


@end

@implementation SDLDrawableView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = self.path;
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    //1.获取一个画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.设置笔触的颜色和粗细
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, WArcColor.CGColor);
    
    //3.划线 将线条绘制到画布上
    CGContextAddPath(context, (self.path));
    
    //4.开始绘制
    CGContextDrawPath(context, kCGPathStroke);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //这个方法是在手指刚挪到视图上的时候调用
    
    UITouch *touch = [touches anyObject];
    //设置currentPoint
    self.currentPoint = [touch locationInView:self];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //这里也需要将touch取出
    UITouch *touch = [touches anyObject];
    
    //将currentPoint变成prePoint
    self.prePoint = self.currentPoint;
    //再设置currentPoint
    self.currentPoint = [touch locationInView:self];
    //创建两个点之间的线
    CGMutablePathRef subPath = CGPathCreateMutable();
    //先将SubPath的起始点设置为prePoint
    CGPathMoveToPoint(subPath, nil, self.prePoint.x, self.prePoint.y);
    //添加一条直线
    //CGPathAddLineToPoint(subPath, nil, self.currentPoint.x, self.currentPoint.y);
    
    
    //在两点之间加入一个二次贝塞尔曲线
    //CGPathAddQuadCurveToPoint(subPath, nil, self.prePoint.x, self.prePoint.y, self.currentPoint.x, self.currentPoint.y);
    
    
    //将subPath加到self.path路径之中
    
    CGPathAddPath(self.path, nil, subPath);
    //释放
    CGPathRelease(subPath);
    //手动刷新界面
    [self setNeedsDisplay];
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
