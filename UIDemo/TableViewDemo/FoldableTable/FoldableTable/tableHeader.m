//
//  tableHeader.m
//  FoldableTable
//
//  Created by haojin on 16/9/4.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "tableHeader.h"
@interface tableHeader()
@property (nonatomic, strong) UIButton *button;
@end

@implementation tableHeader

- (instancetype)initWithFrame:(CGRect)frame headerTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UIButton alloc] initWithFrame:frame];
        [self addSubview:_button];
        [_button setTitle:title forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //注意是setbackgroundImage  不是setImage
        [_button setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)buttonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTableHeaderClicked:)]) {
        [self.delegate didTableHeaderClicked:self];
    }
}

@end
