//
//  MyView.m
//  QuartzDemo01
//
//  Created by haojin on 16/9/25.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "MyView.h"

@implementation MyView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawTriangle];
    [self drawRectangle];
    [self drawEllipse];
    [self drawArc];
    [self drawBezier01];
    [self drawBezier02];
}

//三角形
- (void)drawTriangle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 20);
    CGContextAddLineToPoint(context, 10, 50);
    CGContextAddLineToPoint(context, 100, 50);
    CGContextClosePath(context);
    
    [[UIColor redColor] setStroke];
    [[UIColor greenColor] setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

//长方形
- (void)drawRectangle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect angle = CGRectMake(10, 60, 100, 50);
    CGContextAddRect(context, angle);
    
    [[UIColor yellowColor] set];
    CGContextDrawPath(context, kCGPathFillStroke);
}

//椭圆
- (void)drawEllipse
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect angle = CGRectMake(10, 120, 100, 50);
    CGContextAddEllipseInRect(context, angle);
    
    [[UIColor redColor] set];
    CGContextDrawPath(context, kCGPathFillStroke);
}

//圆
- (void)drawArc
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, 30, 200, 20, 0, M_PI_2, 1);
    [[UIColor blueColor] set];
    CGContextDrawPath(context, kCGPathFillStroke);
}

//贝塞尔01
- (void)drawBezier01
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 250);
    CGContextAddQuadCurveToPoint(context, 60, 230, 110, 250);
    [[UIColor greenColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
}

//贝塞尔02
- (void)drawBezier02
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 300);
    CGContextAddCurveToPoint(context, 20, 270, 120, 300, 110, 260) ;
    [[UIColor yellowColor] setStroke];
    [[UIColor redColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}
 
@end
