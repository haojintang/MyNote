//
//  ViewController.m
//  EditTableViewDemo
//
//  Created by haojin on 16/8/24.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_RECT [UIScreen mainScreen].bounds
#define CELL_IDENTIFY   @"CELL"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSString *> *data;
@property (nonatomic, assign) BOOL isEditing;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.tableView = [[UITableView alloc] initWithFrame:SCREEN_RECT style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(reload:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.title = @"table demo";
    NSArray *array = @[@"tanghaojin",@"zhangsan",@"lisi",@"wangerxiao",@"cheng jian",@"ma zi",@"da bing",@"abc",@"we sheng",@"liu yifei",@"jie dong"];
    self.data = [[NSMutableArray alloc] initWithArray:array];
}

- (void)rightItemClick:(id)sender
{
    if (!self.isEditing) {
       [self setEditing:YES animated:YES];
        self.isEditing = YES;
    } else {
        [self setEditing:NO animated:YES];
        self.isEditing = NO;
    }
    
}

- (void)reload:(id)sender
{
    [self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

#pragma -mark dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFY];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFY];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

#pragma -mark delegate
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *source = self.data[sourceIndexPath.row];
    [self.data removeObjectAtIndex:sourceIndexPath.row];
    [self.data insertObject:source atIndex:destinationIndexPath.row];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSString *txt = self.data[indexPath.row];
        [self.data insertObject:txt atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}


@end
