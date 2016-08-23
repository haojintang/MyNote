//
//  PageScrollView1.m
//  ScrollViewDemo
//
//  Created by haojin on 16/8/14.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "PageScrollView1.h"

#define SCREEN_BOUND   [UIScreen mainScreen].bounds
#define SCROLLVIEW_HEIGHT 120
#define PAGE_WIDTH      300
#define PAGE_HEIGHT     100
#define PAGE_NUM        6
#define PAGE_PADDING    12


@interface PageScrollView1 ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PageScrollView1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    //set background color
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat scrollViewY = (SCREEN_BOUND.size.height - SCROLLVIEW_HEIGHT) / 2;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, SCREEN_BOUND.size.width, SCROLLVIEW_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.scrollView];
    CGFloat contentWidth = (PAGE_PADDING + PAGE_WIDTH) * PAGE_NUM;
    self.scrollView.contentSize = CGSizeMake(contentWidth, SCROLLVIEW_HEIGHT);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    
    //cancel button
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_BOUND.size.width - 100)/2, SCREEN_BOUND.size.height - 60, 100, 30)];
    cancelBtn.backgroundColor = [UIColor redColor];
    [cancelBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(dismissPage:) forControlEvents:UIControlEventTouchUpInside];
    
    //setup subViews
    [self setupScrollPages];
}

- (void)setupScrollPages
{
    CGFloat x = PAGE_PADDING;
    CGFloat y = (SCROLLVIEW_HEIGHT - PAGE_HEIGHT) / 2;
    for (int i=0; i<PAGE_NUM; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, PAGE_WIDTH, PAGE_HEIGHT)];
        view.backgroundColor = [UIColor redColor];
        x += (PAGE_WIDTH + PAGE_PADDING);
        [self.scrollView addSubview:view];
        UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"page_%d",i + 1];
        [label sizeToFit];
        [view addSubview:label];
        label.center = CGPointMake(PAGE_WIDTH/2, PAGE_HEIGHT/2);
    }
    
}

- (void)dismissPage:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollToTargetOffset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollToTargetOffset];
}

- (void)scrollToTargetOffset
{
    [self.scrollView setContentOffset:[self nearestTargetOffset] animated:YES];
}

- (CGPoint)nearestTargetOffset
{
    CGFloat currentX = self.scrollView.contentOffset.x;
    NSInteger targetPage = roundf(currentX / (PAGE_WIDTH + PAGE_PADDING));
    CGFloat targetX = targetPage * (PAGE_PADDING + PAGE_WIDTH);
    if (targetX + SCREEN_BOUND.size.width > self.scrollView.contentSize.width) {
        targetX = self.scrollView.contentSize.width - SCREEN_BOUND.size.width;
    }
    return CGPointMake(targetX, self.scrollView.contentOffset.y);
}



@end
