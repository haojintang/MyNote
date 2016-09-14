//
//  MyRefreshView.m
//  MyRefreshTable
//
//  Created by haojin on 16/9/13.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "MyRefreshView.h"
#import "MyRefreshLayer.h"

#define SCREEN_RECT [UIScreen mainScreen].bounds

#define SCROLLVIEW_DRAG_OFFSET  64

@interface MyRefreshView()
@property (nonatomic, strong) UILabel *reFreshLabel;
@property (nonatomic, strong) MyRefreshLayer *refreshLayer;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MyRefreshView
- (instancetype)initWithFrame:(CGRect)frame andScrollView:(UIScrollView *)scrollView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = scrollView;
        [self setupUI];
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)setupUI
{
    self.refreshLayer = [[MyRefreshLayer alloc] init];
    self.refreshLayer.frame = CGRectMake(SCREEN_RECT.size.width/2 - self.frame.size.width/2, -SCROLLVIEW_DRAG_OFFSET/2 - self.frame.size.height * 3 / 5, self.frame.size.width, self.frame.size.height);
    [self.scrollView.layer addSublayer:self.refreshLayer];
    [self.refreshLayer setNeedsDisplay];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (contentOffset.y <= -64) {
             [self refreshAnimation];
            [UIView animateWithDuration:0.3f animations:^{
               self.scrollView.contentInset = UIEdgeInsetsMake(90, 0, 0, 0);
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self stopRefreshAnimation];
                [UIView animateWithDuration:0.3f animations:^{
                   self.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
                }];
            });
        } else {
            [self stopRefreshAnimation];
        }
    }
}

- (void)stopRefreshAnimation
{
    [self.refreshLayer removeAllAnimations];
}

- (void)refreshAnimation
{
    CABasicAnimation *rotationZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationZ.fromValue = @(0);
    rotationZ.toValue = @(M_PI*2);
    rotationZ.repeatDuration = HUGE_VAL;
    rotationZ.duration = 1.0;
   [self.refreshLayer addAnimation:rotationZ forKey:@"headerRotationZ"];
}

@end
