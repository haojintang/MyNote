//
//  ShineAnimationView.m
//  AnimateDemo01
//
//  Created by haojin on 16/10/8.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ShineAnimationView.h"
@interface ShineAnimationView()
@property (nonatomic, strong) CAShapeLayer *redCircle;
@property (nonatomic, strong) CAShapeLayer *yellowCircle;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIView *animateView;
@end

@implementation ShineAnimationView

- (void)showAnimation
{
    self.backgroundColor = [UIColor whiteColor];
    self.animateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self addSubview:self.animateView];
    self.animateView.center = self.center;
    self.animateView.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.animateView.bounds.size.width/2.f, self.animateView.bounds.size.height/2.f) radius:20 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    self.redCircle = [[CAShapeLayer alloc] init];
    self.redCircle.path = path.CGPath;
    self.redCircle.fillColor = [UIColor redColor].CGColor;
    [self.animateView.layer addSublayer:self.redCircle];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:CGPointMake(self.animateView.bounds.size.width/2.f, self.animateView.bounds.size.height/2.f) radius:40 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    self.yellowCircle = [[CAShapeLayer alloc] init];
    self.yellowCircle.path = path1.CGPath;
    self.yellowCircle.fillColor = [UIColor yellowColor].CGColor;
    [self.animateView.layer insertSublayer:self.yellowCircle below:self.redCircle];
    
    self.maskLayer = [[CAShapeLayer alloc] init];
    self.animateView.layer.mask = self.maskLayer;
    
    
    [self startShineAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startMovingAnimation];
    });
    
}

- (void)startShineAnimation
{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"path"];
    ani.fromValue = (__bridge id)self.redCircle.path;
    ani.toValue = (__bridge id)self.yellowCircle.path;
    ani.duration = 0.5;
    ani.repeatCount = 5;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeBoth;
    
    [self.maskLayer addAnimation:ani forKey:@"shinning"];
}

- (void)startMovingAnimation
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CAKeyframeAnimation *movAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.center];
    [path addLineToPoint:CGPointMake(self.center.x, 0)];
    movAni.path = path.CGPath;
    movAni.duration = 5;
    movAni.repeatCount = 1;
    [self.animateView.layer addAnimation:movAni forKey:@"moving"];
    [CATransaction commit];
}

@end
