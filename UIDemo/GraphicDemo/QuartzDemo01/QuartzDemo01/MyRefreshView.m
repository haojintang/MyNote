//
//  MyRefreshView.m
//  QuartzDemo01
//
//  Created by haojin on 16/10/1.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "MyRefreshView.h"

@implementation MyRefreshView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSString *str = @"hello world";
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:self.font}];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self setNeedsDisplay];
}

@end
