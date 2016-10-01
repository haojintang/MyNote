//
//  Button02View.m
//  QuartzDemo01
//
//  Created by haojin on 16/9/30.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "Button02View.h"

@implementation Button02View

//context 会维护一个栈，用于存储graphics state，
//可以使用CGContextSaveGState和CGContextRestoreGState进行push和pop
- (void)drawRect:(CGRect)rect {
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect upRect = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height/2 - 40);
    CGRect downRect = CGRectMake(0, screenRect.size.height/2.0 + 40, screenRect.size.width, screenRect.size.height/2  - 40);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //注意入栈
    CGContextSaveGState(context);
    [self drawLinearGradientFill:context andRect:upRect];
    CGContextRestoreGState(context);
    //注意出栈
    [self drawRadialGradientFill:context andRect:downRect];
}

- (void)drawLinearGradientFill:(CGContextRef)context andRect:(CGRect)rect
{
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    //裁切处一块矩形用于显示，注意必须先裁切再调用渐变
    //CGContextClipToRect(context, CGRectMake(20, 50, 280, 300));
    //裁切还可以使用UIKit中对应的方法
    UIRectClip(rect);
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
   
    //对角线渐变
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.origin.x, rect.origin.y), CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

- (void)drawRadialGradientFill:(CGContextRef)context andRect:(CGRect)rect
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIRectClip(rect);
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGPoint center = CGPointMake(rect.origin.x + rect.size.width/2,rect.origin.y + rect.size.height/2);
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    CGContextDrawRadialGradient(context, gradient, center, 0, center, rect.size.width/2 - 40,kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(colorSpace);
}

@end
