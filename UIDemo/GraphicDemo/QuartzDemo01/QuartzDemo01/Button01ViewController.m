//
//  Button01ViewController.m
//  QuartzDemo01
//
//  Created by haojin on 16/9/30.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "Button01ViewController.h"
#import "Button01View.h"
#import "Button02View.h"
#import "Button03View.h"
#import "Button04View.h"
#import "Button05View.h"

@interface Button01ViewController ()
@property (nonatomic, assign) MyButtonStyle buttonStyle;
@end

@implementation Button01ViewController

- (instancetype)initWithButtonType:(MyButtonStyle)buttonStyle
{
    self = [super init];
    if (self) {
       _buttonStyle = buttonStyle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [self getDrawViewForStyle:self.buttonStyle];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 0, 100, 30)];
    [self.view addSubview:dismissButton];
    [dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
    dismissButton.backgroundColor = [UIColor blackColor];
    [dismissButton addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)getDrawViewForStyle:(MyButtonStyle)style
{
    UIView *myView = nil;
    switch (style) {
        case MyButton01:
            myView = [[Button01View alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        case MyButton02:
            myView = [[Button02View alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        case MyButton03:
            myView = [[Button03View alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        case MyButton04:
            myView = [[Button04View alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        case MyButton05:
            myView = [[Button05View alloc] initWithFrame:[UIScreen mainScreen].bounds];
            break;
        default:
            break;
    }
    return myView;
}

- (void)dismissClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
