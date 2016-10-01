//
//  Button05View.m
//  QuartzDemo01
//
//  Created by haojin on 16/10/1.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "Button05View.h"

@implementation Button05View

//图像上下文变换，形变
//注意坐标原点的位置，UIkit在左上方；2d 在左下方
//进行变换的时候要记得保存和还原contextState，避免原点错乱
//对于图像变换，uiview有一个transform属性可以方便的做到
//下面看看2d是怎么实现的
//需要特别注意理解：旋转的不是图片本身，旋转的是整个坐标系！！！！
//特别注意uikit和2d的原点位置不同，如果使用2d绘图，则图像可能是倒着的。
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self transformImage:context];
}

- (void)transformImage:(CGContextRef)context
{
    UIImage *image = [UIImage imageNamed:@"1.png"];
    [image drawInRect:CGRectMake(100, 100, 100, 100)];
    
    CGContextSaveGState(context);
    //平移40point
    CGContextTranslateCTM(context, 40, 0);
    //缩小到0.8
    CGContextScaleCTM(context, 0.8, 0.8);
    
    //旋转,特别注意，旋转是沿着原点进行的，平移后原点位置（40，0）
    //特别注意理解变换，旋转的不是图片本身，旋转的是整个坐标系
    CGContextRotateCTM(context, M_PI_4);
    
    //uikit的方式，原点是左上方的，如果使用cgcontextdrawimage则图像会倒置
    [image drawInRect:CGRectMake(100, 100, 100, 100)];
    
    CGContextRestoreGState(context);
}

@end
