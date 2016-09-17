//
//  ViewController.m
//  AutoLayoutDemo04
//
//  Created by haojin on 16/9/17.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.label = [[UILabel alloc] init];
    self.label.text = @"my label";
    [self.label sizeToFit];
    self.label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.label];
    
    [self.label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *labelConY = [NSLayoutConstraint constraintWithItem:self.label
                                                                attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0];
    NSLayoutConstraint *labelConX = [NSLayoutConstraint constraintWithItem:self.label
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.0
                                                                  constant:0];
    [self.view addConstraint:labelConX];
    [self.view addConstraint:labelConY];
    
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = [UIColor redColor];
    [self.button setTitle:@"my Button" forState:UIControlStateNormal];
    [self.button sizeToFit];
    [self.view addSubview:self.button];
    [self.button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *buttonConY = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.button attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10];
    NSLayoutConstraint *buttonConX = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.button attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:buttonConX];
    [self.view addConstraint:buttonConY];
    
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick:(id)sender
{
    if ([self.button.titleLabel.text isEqualToString:@"my Button"]) {
        [self.button setTitle:@"button clicked, hahaha~" forState:UIControlStateNormal];
    } else {
        [self.button setTitle:@"my Button" forState:UIControlStateNormal];
    }
}

@end
