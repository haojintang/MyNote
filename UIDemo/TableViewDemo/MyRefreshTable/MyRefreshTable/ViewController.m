//
//  ViewController.m
//  MyRefreshTable
//
//  Created by haojin on 16/9/13.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"
#import "MyRefreshView.h"

#define REFRESH_VIEW_WIDTH  100
#define REFRESH_VIEW_HEIGHT 40
#define SCREEN_RECT [UIScreen mainScreen].bounds

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MyRefreshView *refreshView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self setupRefreshView];
}

- (void)setupRefreshView
{
    MyRefreshView *freshView = [[MyRefreshView alloc] initWithFrame:CGRectMake(0, 0, REFRESH_VIEW_WIDTH, REFRESH_VIEW_HEIGHT) andScrollView:self.tableView];
    self.refreshView = freshView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = @"hello world";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}


@end
