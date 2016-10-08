//
//  ViewController.m
//  AnimateDemo01
//
//  Created by haojin on 16/10/8.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"

#import "AnimateViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *shineButton;//发光动画，伴随移动效果

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shineButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
    [self.view addSubview:self.shineButton];
    self.shineButton.backgroundColor = [UIColor greenColor];
    [self.shineButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shineButton.tag = 0;
    [self.shineButton setTitle:@"闪烁动画" forState:UIControlStateNormal];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)buttonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    AnimateViewController *controller = [[AnimateViewController alloc] initWithButtonType:button.tag];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
