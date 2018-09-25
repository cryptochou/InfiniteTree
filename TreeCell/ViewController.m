//
//  ViewController.m
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"
#import "TestModel.h"
#import "InfiniteTreeCell.h"
#import "UITableView+InfiniteTree.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSMutableArray *infiniteSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infiniteSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = [TestCell infiniteTreeCellWithTableView:tableView];
    cell.titleLab.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    InfiniteTreeModel *model = self.infiniteSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [tableView if_dealSelectAtIndexPath:indexPath sourceArray:self.infiniteSource];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100;
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            TestModel *model = [[TestModel alloc] init];
            model.title = [NSString stringWithFormat:@"title---%d", i];
            NSMutableArray *arrayI = [NSMutableArray array];
            model.childrens = arrayI;
            [array addObject:model];
            
            for (int j = 0; j < 10; j++) {
                TestModel *model = [[TestModel alloc] init];
                model.title = [NSString stringWithFormat:@"detail-title---%d-%d", i, j];
                NSMutableArray *arrayJ = [NSMutableArray array];
                model.childrens = arrayJ;
                [arrayI addObject:model];
                
                for (int k = 0; k < 10; k++) {
                    TestModel *model = [[TestModel alloc] init];
                    model.title = [NSString stringWithFormat:@"detail-title-ddtt---%d-%d-%d", i, j, k];
                    NSMutableArray *arrayk = [NSMutableArray array];
                    model.childrens = arrayk;
                    [arrayJ addObject:model];
                    
                    for (int l = 0; l < 10; l++) {
                        TestModel *model = [[TestModel alloc] init];
                        model.title = [NSString stringWithFormat:@"detail-title-ddtt--tttttt---%d-%d-%d-%d", i, j, k, l];
                        [arrayk addObject:model];
                    }
                }
            }
        }
        _dataSource = array;
    }
    return _dataSource;
}

- (NSMutableArray *)infiniteSource
{
    if (!_infiniteSource) {
        _infiniteSource = [NSMutableArray arrayWithArray:[InfiniteTreeModel infiniteTreeModelArrayWithDataModels:self.dataSource]];
    }
    return _infiniteSource;
}

@end
