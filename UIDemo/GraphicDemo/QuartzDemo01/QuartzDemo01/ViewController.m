//
//  ViewController.m
//  QuartzDemo01
//
//  Created by haojin on 16/9/25.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"
#import "Button01ViewController.h"
#import "RefreshViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button01;
@property (nonatomic, strong) UIButton *button02;
@property (nonatomic, strong) UIButton *button03;
@property (nonatomic, strong) UIButton *button04;
@property (nonatomic, strong) UIButton *button05;
@property (nonatomic, strong) UIButton *refreshView;
@property (nonatomic, strong) UIButton *drawImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buttonSetUp];
    
}

- (void)buttonSetUp
{
    self.button01 = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 100, 30)];
    [self.view addSubview:self.button01];
    [self.button01 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button01];
    [self.button01 setTitle:@"基础绘图" forState:UIControlStateNormal];
    self.button01.backgroundColor = [UIColor greenColor];
    self.button01.tag = MyButton01;
    
    self.button02 = [[UIButton alloc] initWithFrame:CGRectMake(15, 70, 100, 30)];
    [self.view addSubview:self.button02];
    [self.button02 setTitle:@"渐变绘制" forState:UIControlStateNormal];
    [self.button02 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.button02.backgroundColor = [UIColor greenColor];
    self.button02.tag = MyButton02;
    
    self.button03 = [[UIButton alloc] initWithFrame:CGRectMake(15, 120, 100, 30)];
    [self.view addSubview:self.button03];
    [self.button03 setTitle:@"叠加效果" forState:UIControlStateNormal];
    [self.button03 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.button03.backgroundColor = [UIColor greenColor];
    self.button03.tag = MyButton03;
    
    self.button04 = [[UIButton alloc] initWithFrame:CGRectMake(15, 170, 100, 30)];
    [self.view addSubview:self.button04];
    [self.button04 setTitle:@"填充模式" forState:UIControlStateNormal];
    [self.button04 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.button04.backgroundColor = [UIColor greenColor];
    self.button04.tag = MyButton04;
    
    self.button05 = [[UIButton alloc] initWithFrame:CGRectMake(15, 220, 100, 30)];
    [self.view addSubview:self.button05];
    [self.button05 setTitle:@"图像变换" forState:UIControlStateNormal];
    [self.button05 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.button05.backgroundColor = [UIColor greenColor];
    self.button05.tag = MyButton05;
    
    self.refreshView = [[UIButton alloc] initWithFrame:CGRectMake(15, 220, 100, 30)];
    [self.view addSubview:self.refreshView];
    [self.refreshView setTitle:@"刷新视图" forState:UIControlStateNormal];
    [self.refreshView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.refreshView.backgroundColor = [UIColor greenColor];
    self.refreshView.tag = refreshView;
    
    self.refreshView = [[UIButton alloc] initWithFrame:CGRectMake(15, 220, 200, 30)];
    [self.view addSubview:self.refreshView];
    [self.refreshView setTitle:@"绘制图像-imageContext" forState:UIControlStateNormal];
    [self.refreshView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.refreshView.backgroundColor = [UIColor greenColor];
    self.refreshView.tag = drawImageWithImageContext;
    
}

- (void)buttonClick:(id)sender
{
    UIViewController *controller = nil;
    UIButton *button = (UIButton *)sender;
    if (button.tag == refreshView) {
        controller = [[RefreshViewController alloc] init];
    } else if (button.tag == drawImageWithImageContext) {
        UIImage *image = [self signitureAPicture];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(250, 100, imageView.frame.size.width, imageView.frame.size.height);
        [self.view addSubview:imageView];
        return;
    } else {
        controller = [[Button01ViewController alloc] initWithButtonType:button.tag];
    }
   
    [self presentViewController:controller animated:YES completion:nil];
}

- (UIImage *)signitureAPicture
{
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIImage *image = [UIImage imageNamed:@"1.png"];
    [image drawInRect:CGRectMake(0, 0, 100, 100)];
    // signiture
    NSString *str = @"haojin tang";
    UIFont *font = [UIFont systemFontOfSize:15];
    UIColor *color = [UIColor redColor];
    [str drawInRect:CGRectMake(0, 60, 100, 30) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
