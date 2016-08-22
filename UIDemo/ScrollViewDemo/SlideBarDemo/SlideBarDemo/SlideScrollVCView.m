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
@property (nonatomic, strong) NSMutableArray *VCs;
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
    
    for (int i=0; i<self.titleArray.count; i++) {
        MyViewController *myController = [[MyViewController alloc] init];
        [self.VCs addObject:myController];
        myController.title = self.titleArray[i];
        [self.scrollView addSubview:myController.view];
        [self.controller addChildViewController:myController];
        myController.view.frame = CGRectMake(i * SCREEN_RECT.size.width, 0, SCREEN_RECT.size.width, SCREEN_RECT.size.height);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger page = floor(offset/SCREEN_RECT.size.width);
    [self.delegate scrollToIndex:page];
}

- (void)scrollToIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(SCREEN_RECT.size.width * index, self.scrollView.contentOffset.y) animated:NO];
}

@end
