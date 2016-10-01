//
//  Button01ViewController.h
//  QuartzDemo01
//
//  Created by haojin on 16/9/30.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyButtonStyle) {
    MyButton01,//基础的绘制
    MyButton02,//渐变
    MyButton03,//叠加
    MyButton04,//有颜色填充
    MyButton05,//图形变换
    refreshView,//刷新view
    drawImageWithImageContext,//绘制图像
};

@interface Button01ViewController : UIViewController
- (instancetype)initWithButtonType:(MyButtonStyle)buttonStyle;
@end
