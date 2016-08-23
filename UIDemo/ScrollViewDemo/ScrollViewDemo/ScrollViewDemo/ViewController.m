//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by haojin on 16/8/14.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"
#import "PageScrollView1.h"
#import "PageScrollView2.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"style_%zd",indexPath.row];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PageScrollView1 *viewController = [[PageScrollView1 alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    } else if (indexPath.row == 1){
        PageScrollView2 *view2ctr = [[PageScrollView2 alloc] init];
        [self presentViewController:view2ctr animated:YES completion:nil];
    }
}
@end
