//
//  ViewController.m
//  FoldableTable
//
//  Created by haojin on 16/9/4.
//  Copyright © 2016年 haojin. All rights reserved.
//

#import "ViewController.h"
#import "tableHeader.h"

#define DATA_NAME   @"tableData"
#define CELL_IDENTIFY   @"CELL"
#define SECTION_HEADER_HEIGHT   60
#define SECTION_CELL_HEIGHT     55
#define SCREEN_RECT [UIScreen mainScreen].bounds

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,tableHeaderDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *tableSectionStatus;      //记录section是打开还是关闭
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupUI];
}

- (void)loadData
{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:DATA_NAME ofType:@"plist"];
    self.tableData = [[NSArray alloc] initWithContentsOfFile:dataPath];
    self.tableSectionStatus = [NSMutableArray array];
    //开始时，所有section是关闭的
    for (int i=0; i < self.tableData.count; i++) {
        [self.tableSectionStatus addObject:@(0)];
    }
}

- (void)setupUI
{
    self.tableView = [[UITableView alloc] initWithFrame:SCREEN_RECT style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.sectionFooterHeight = 0;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma -mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rows = self.tableData[section];
    int sectionStatus = self.tableSectionStatus[section].intValue;
    if (sectionStatus == 0) {
        return 0;
    } else {
        return rows.count -1;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.tableData[section][0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFY];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFY];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_RECT.size.width, SECTION_CELL_HEIGHT)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_2_normal.png"] forState:UIControlStateNormal];
        cell.backgroundView = btn;
        
        UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, btn.frame.size.height -1, btn.frame.size.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        [btn addSubview:line];
    }
    
    NSArray *section = self.tableData[indexPath.section];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.text = section[indexPath.row+1];
    return cell;
}

#pragma -mark tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, SCREEN_RECT.size.width, SECTION_HEADER_HEIGHT);
    NSString *title = self.tableData[section][0];
    tableHeader *header = [[tableHeader alloc] initWithFrame:frame headerTitle:title];
    header.delegate = self;
    header.sectionIndex = section;
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SECTION_CELL_HEIGHT;
}

#pragma -mark tableHeader delegate

- (void)didTableHeaderClicked:(id)header
{
    tableHeader *clickedHeader = (tableHeader *)header;
    NSInteger section = clickedHeader.sectionIndex;
    if(self.tableSectionStatus[section].intValue == 0) {
        self.tableSectionStatus[section] = @(1);
    } else {
        self.tableSectionStatus[section] = @(0);
    }
    [self.tableView reloadData];
}

@end
