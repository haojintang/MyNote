//
//  SlideScrollVCView.m
//  SlideBarDemo
//
//  Created by jinatang on 16/8/22.
//  Copyright © 2016年 jinatang. All rights reserved.
//

#import "SlideScrollVCView.h"
#import "MyViewController.h"
#define SCREEN_RECT     [UIScreen mainScreen].bounds

@interface SlideScrollVCView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,UIViewController *> *reuseDic;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIViewController *controller;
@end

@implementation SlideScrollVCView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray<NSString *> *) titleArray controller:(UIViewController *)controller
{
    self = [super initWithFrame:frame];
    if(self) {
        self.titleArray = titleArray;
        self.controller = controller;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:SCREEN_RECT];
    [self addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(self.titleArray.count * SCREEN_RECT.size.width, SCREEN_RECT.size.height);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    [self loadPage:0];
    [self loadPage:1];
}

- (void)loadPage:(NSInteger)pageIndex
{
    if (pageIndex < 0 || pageIndex >= self.titleArray.count) {
        return;
    }
    if (!self.reuseDic) {
        self.reuseDic = [NSMutableDictionary dictionary];
    }
    if (!self.reuseDic[@(pageIndex)]) {
        MyViewController *myController = [[MyViewController alloc]  init];
        self.reuseDic[@(pageIndex)] = myController;
        myController.title = self.titleArray[pageIndex];
        [self.controller addChildViewController:myController];
        [self.scrollView addSubview:myController.view];
        myController.view.frame = CGRectMake(pageIndex * SCREEN_RECT.size.width, 0, SCREEN_RECT.size.width, SCREEN_RECT.size.height);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger page = floor(offset/SCREEN_RECT.size.width);
    [self loadPage:page];
    [self loadPage:page - 1];
    [self loadPage:page + 1];
    [self.delegate scrollToIndex:page];
}

- (void)scrollToIndex:(NSInteger)index
{
    [self loadPage:index];
    [self loadPage:index - 1];
    [self loadPage:index + 1];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_RECT.size.width * index, self.scrollView.contentOffset.y) animated:NO];
}

@end
