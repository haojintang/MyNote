//
//  SlideScrollVCView.h
//  SlideBarDemo
//
//  Created by jinatang on 16/8/22.
//  Copyright © 2016年 jinatang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MySlideViewDelegate
- (void)scrollToIndex:(NSInteger)index;
@end


@interface SlideScrollVCView : UIView<MySlideViewDelegate>
@property (nonatomic, weak)id<MySlideViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray<NSString *> *) titleArray controller:(UIViewController *)controller;

@end
