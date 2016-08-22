//
//  SlideButtonScrollView.m
//  SlideBarDemo
//
//  Created by jinatang on 16/8/17.
//  Copyright © 2016年 jinatang. All rights reserved.
//

#import "SlideButtonScrollView.h"
#define SCREEN_RECT     [UIScreen mainScreen].bounds
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define buttonBlankWidth    20
#define titleFontSize       14
#define VIEW_HEIGHT         30

@interface SlideButtonScrollView()
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *titleXoffset;
@property (nonatomic, strong) UIView *cursorView;       //光标
//@property (nonatomic, strong) NSMutableArray<UIButton *> *reuseButtons;   //button需要能够复用
@end

@implementation SlideButtonScrollView


- (instancetype)initWithFrame:(CGRect)frame AndTitles:(NSArray<NSString *> *) titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = titleArray;
        [self setupUI];
        self.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return self;
}

- (void)setupUI
{
    self.titleXoffset = [[NSMutableArray alloc] init];
    CGFloat xoffset = 0.f;
    [self.titleXoffset addObject:@(xoffset)];
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *button = [self setupSubButtonWithTitle:self.titleArray[i]];
        [self addSubview:button];
        button.frame = CGRectMake(xoffset, 0, button.frame.size.width, button.frame.size.height);
        xoffset += button.bounds.size.width;
        [self.titleXoffset addObject:@(xoffset)];
    }
    self.contentSize = CGSizeMake([[self.titleXoffset lastObject] floatValue], VIEW_HEIGHT);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (UIButton *)setupSubButtonWithTitle:(NSString *)title
{
    UIFont *font = [UIFont systemFontOfSize:titleFontSize];
    CGFloat buttonHeight = VIEW_HEIGHT;
    CGSize size = [title sizeWithFont:font];
    CGFloat buttonWidth = size.width + buttonBlankWidth;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:UIColorFromRGB(0x868686) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x5c8aea) forState:UIControlStateSelected];
    button.selected = YES;
    button.titleLabel.font = font;
    button.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClick
{
    NSLog(@"button click");
}

- (void)setupCursorView:(CGRect)rect
{
    if (!self.cursorView) {
        self.cursorView = [[UIView alloc] initWithFrame:rect];
        self.cursorView.backgroundColor = UIColorFromRGB(0x5c8aea);
    }
    self.cursorView.frame = rect;
}

@end
