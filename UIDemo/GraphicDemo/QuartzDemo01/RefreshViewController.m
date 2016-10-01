//
//  RefreshViewController.m
//  QuartzDemo01
//
//  Created by haojin on 16/10/1.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "RefreshViewController.h"
#import "MyRefreshView.h"

@interface RefreshViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) MyRefreshView *wordView;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *sizeArray;
@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 0, 100, 30)];
    [self.view addSubview:dismissButton];
    [dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
    dismissButton.backgroundColor = [UIColor blackColor];
    [dismissButton addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.wordView = [[MyRefreshView alloc] initWithFrame:CGRectMake(100, 50, 100, 50)];
    self.wordView.backgroundColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.wordView];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 200, 250, 200)];
    [self.view addSubview:self.pickerView];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSArray *)sizeArray
{
    if (!_sizeArray) {
        _sizeArray = @[@12,@14,@16,@18,@20];
    }
    return _sizeArray;
}

- (void)setFont:(UIFont *)font
{
    self.wordView.font = font;
    _font = font;
}

- (void)dismissClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark pickerView delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.sizeArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSNumber *number = self.sizeArray[row];
    return [NSString stringWithFormat:@"font size: %d",[number intValue]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSNumber *number = self.sizeArray[row];
    self.font = [UIFont systemFontOfSize:[number intValue]];
}

@end
