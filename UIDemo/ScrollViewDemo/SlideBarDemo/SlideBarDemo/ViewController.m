//
//  ViewController.m
//  SlideBarDemo
//
//  Created by jinatang on 16/8/17.
//  Copyright © 2016年 jinatang. All rights reserved.
//

#import "ViewController.h"
#import "SlideButtonScrollView.h"
#import "SlideScrollVCView.h"
#define VIEW_HEIGHT        44
#define SCREEN_RECT     [UIScreen mainScreen].bounds
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"语文",@"属性书慈",@"应用",@"属性",@"医药",@"环保",@"挂会",@"股市",@"腾讯",@"分享"];
    SlideButtonScrollView *buttonView = [[SlideButtonScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_RECT.size.width, VIEW_HEIGHT) AndTitles:array];
    [self.view addSubview:buttonView];
    
    SlideScrollVCView *scrollView = [[SlideScrollVCView alloc] initWithFrame:SCREEN_RECT titleArray:array controller:self];
    [self.view addSubview:scrollView];
    [self.view sendSubviewToBack:scrollView];
    
    buttonView.delegate = scrollView;
    scrollView.delegate = buttonView;
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
