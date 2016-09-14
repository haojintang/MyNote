//
//  MyRefreshLayer.m
//  MyRefreshTable
//
//  Created by haojin on 16/9/13.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "MyRefreshLayer.h"
#import <UIKit/UIKit.h>

#define CIRCLE_WIDTH    15
#define CIRCLE_LINEWIDTH    2.f

@implementation MyRefreshLayer
- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = CIRCLE_LINEWIDTH;
    [path1 addArcWithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:CIRCLE_WIDTH startAngle:-M_PI endAngle:0 clockwise:YES];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    path2.lineWidth = CIRCLE_LINEWIDTH;
    [path2 addArcWithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:CIRCLE_WIDTH startAngle:0 endAngle:M_PI clockwise:YES];
    [[UIColor redColor] setStroke];
    [path1 stroke];
    [[UIColor blackColor] setStroke];
    [path2 stroke];
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
}
@end
