//
//  ViewController.m
//  SlideBarDemo
//
//  Created by jinatang on 16/8/17.
//  Copyright © 2016年 jinatang. All rights reserved.
//

#import "ViewController.h"
#import "SlideButtonScrollView.h"
#define VIEW_HEIGHT         30
#define SCREEN_RECT     [UIScreen mainScreen].bounds
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SlideButtonScrollView *buttonView = [[SlideButtonScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_RECT.size.width, VIEW_HEIGHT) AndTitles:@[@"语文",@"属性书慈",@"应用",@"属性",@"医药",@"环保",@"挂会",@"股市",@"腾讯",@"分享"]];
    [self.view addSubview:buttonView];
}

- (void)buttonClick
{
    NSLog(@"lalala");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
