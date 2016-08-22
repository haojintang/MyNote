//
//  SlideButtonScrollView.h
//  SlideBarDemo
//
//  Created by jinatang on 16/8/17.
//  Copyright © 2016年 jinatang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideScrollVCView.h"

@interface SlideButtonScrollView : UIScrollView<MySlideViewDelegate>
@property (nonatomic, weak)id<MySlideViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame AndTitles:(NSArray<NSString *> *) titleArray;

@end
