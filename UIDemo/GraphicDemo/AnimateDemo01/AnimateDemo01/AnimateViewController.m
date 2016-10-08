//
//  AnimateViewController.m
//  AnimateDemo01
//
//  Created by haojin on 16/10/8.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "AnimateViewController.h"
#import "ShineAnimationView.h"


@interface AnimateViewController ()
@property (nonatomic,assign)NSUInteger buttonType;
@end

@implementation AnimateViewController

- (instancetype)initWithButtonType:(NSUInteger)buttonType
{
    self = [super init];
    if (self) {
        _buttonType = buttonType;
    }
    return self;
}

- (void)viewDidLoad
{
    if (self.buttonType == 0) {
        ShineAnimationView *shineView = [[ShineAnimationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:shineView];
        [shineView showAnimation];
    }
}



@end
