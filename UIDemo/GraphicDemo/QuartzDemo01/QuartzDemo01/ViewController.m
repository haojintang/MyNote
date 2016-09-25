//
//  ViewController.m
//  QuartzDemo01
//
//  Created by haojin on 16/9/25.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyView *view = [[MyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}


@end
