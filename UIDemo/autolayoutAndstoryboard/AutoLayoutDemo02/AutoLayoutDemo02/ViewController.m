//
//  ViewController.m
//  AutoLayoutDemo02
//
//  Created by haojin on 16/9/17.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTaped:(id)sender {
    UIButton *button = (UIButton *)sender;
    if ([button.currentTitle isEqualToString:@"X"]) {
        [button setTitle:@"what is your name" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"X" forState:UIControlStateNormal];
    }
}


@end
