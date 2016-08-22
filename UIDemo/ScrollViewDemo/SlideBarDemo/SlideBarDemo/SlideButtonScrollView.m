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
#define VIEW_HEIGHT         44 
#define CURSOR_HEIGHT       2

@interface SlideButtonScrollView()
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *titleXoffset;
@property (nonatomic, strong) UIView *cursorView;       //光标
@property (nonatomic, strong) UIButton *selectedButton; //光标选中的button
@property (nonatomic, assign) NSInteger selectedIndex;  //选中的index
@property (nonatomic, strong) NSMutableArray *buttons;
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
    self.buttons = [[NSMutableArray alloc] init];
    self.titleXoffset = [[NSMutableArray alloc] init];
    CGFloat xoffset = 0.f;
    [self.titleXoffset addObject:@(xoffset)];
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *button = [self setupSubButtonWithTitle:self.titleArray[i] buttonIndex:i];
        [self addSubview:button];
        [self.buttons addObject:button];
        button.frame = CGRectMake(xoffset, 0, button.frame.size.width, button.frame.size.height);
        xoffset += button.bounds.size.width;
        [self.titleXoffset addObject:@(xoffset)];
        if (i == 0) {
            [self updateCursorViewForm:0 toIndex:0];
            self.selectedIndex = 0;
            self.selectedButton = button;
            button.selected = YES;
        }
    }
    self.contentSize = CGSizeMake([[self.titleXoffset lastObject] floatValue], VIEW_HEIGHT);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (UIButton *)setupSubButtonWithTitle:(NSString *)title buttonIndex:(NSInteger)index
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
    button.titleLabel.font = font;
    button.backgroundColor = UIColorFromRGB(0xf5f5f5);
    button.tag = index;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClick:(id)sender
{
    NSInteger fromIndex = self.selectedIndex;
    UIButton *clickButton = (UIButton *)sender;
    NSInteger toIndex = clickButton.tag;
    clickButton.selected = YES;
    self.selectedButton.selected = NO;
    self.selectedButton = clickButton;
    self.selectedIndex = toIndex;
    [self updateCursorViewForm:fromIndex toIndex:toIndex];
    [self scrollToRightOffset:toIndex];
    [self.delegate scrollToIndex:toIndex];
}

- (void)updateCursorViewForm:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    if (!self.cursorView) {
        self.cursorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, CURSOR_HEIGHT)];
        self.cursorView.backgroundColor = UIColorFromRGB(0x5c8aea);
        [self addSubview:self.cursorView];
        [self bringSubviewToFront:self.cursorView];
    }
    CGFloat width = 0;
    if (fromIndex >= 0 && fromIndex + 1 < self.titleXoffset.count) {
        width = self.titleXoffset[fromIndex + 1].floatValue - self.titleXoffset[fromIndex].floatValue;
    } else {
        return;
    }
    self.cursorView.frame = CGRectMake(self.titleXoffset[fromIndex].floatValue, self.frame.size.height - CURSOR_HEIGHT, width, CURSOR_HEIGHT);
    if (fromIndex == toIndex) {
        return;
    }
    
    if (toIndex >= 0 && toIndex + 1 < self.titleXoffset.count) {
        CGFloat width = self.titleXoffset[toIndex + 1].floatValue - self.titleXoffset[toIndex].floatValue;
        [self bringSubviewToFront:self.cursorView];
        [UIView animateWithDuration:0.5 animations:^{
            self.cursorView.frame = CGRectMake(self.titleXoffset[toIndex].floatValue, self.cursorView.frame.origin.y, width, self.cursorView.frame.size.height);
        }];
    }
}

- (void)scrollToRightOffset:(NSInteger)index
{
    if (index >= 0 && index + 1 < self.titleXoffset.count) {
        CGFloat xOffset = self.titleXoffset[index].floatValue;
        CGFloat width = self.titleXoffset[index + 1].floatValue - self.titleXoffset[index].floatValue;
        CGFloat midOffset = xOffset + width/2.0;
        if (midOffset < SCREEN_RECT.size.width/2) {
            [self setContentOffset:CGPointMake(0, self.contentOffset.y) animated:YES];
        } else if (self.contentSize.width - midOffset < SCREEN_RECT.size.width/2) {
            [self setContentOffset:CGPointMake(self.contentSize.width - SCREEN_RECT.size.width, self.contentOffset.y) animated:YES];
        } else {
            [self setContentOffset:CGPointMake(midOffset - SCREEN_RECT.size
                                               .width / 2, self.contentOffset.y) animated:YES];
        }
    }
}

- (void)scrollToIndex:(NSInteger)index
{
    NSInteger fromIndex = self.selectedIndex;
    if (index == fromIndex) {
        return;
    }
    if (index < 0 || index >= self.buttons.count) {
        return;
    }
    UIButton *clickButton = self.buttons[index];
    clickButton.selected = YES;
    self.selectedButton.selected = NO;
    self.selectedButton = clickButton;
    self.selectedIndex = index;
    [self updateCursorViewForm:fromIndex toIndex:index];
    [self scrollToRightOffset:index];
}

@end
