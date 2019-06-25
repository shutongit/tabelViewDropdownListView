//
//  ViewController.m
//  Demo
//
//  Created by shutong on 2019/6/24.
//  Copyright © 2019 shutong. All rights reserved.
//

#import "ViewController.h"

#import "ShowTableViewCell.h"
#import "DropdownListView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@end
static NSString *cellID = @"identifyCellId";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *array = @[@"姓名：",@"专业名称:",@"宿舍楼:",@"兴趣爱好:",@"喜欢玩的游戏:",@"最讨厌的人:"];
//    CGFloat y = 80;
//    for (int i = 0; i < array.count; i ++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, y + (30 * i), 100, 30)];
//        label.text = array[i];
//        label.backgroundColor = [UIColor lightGrayColor];
//        [label textAlignmentLeftAndRight];
//        [self.view addSubview:label];
//    }
    [self.view addSubview:self.tableView];
    [self loadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ShowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor blueColor].CGColor;
    [cell configureData:self.dataSource];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

#pragma mark ************* load data *************
- (void)loadData
{
    for (int i = 0; i < 25; i ++) {
        DropdownItem *item = [[DropdownItem alloc]initWithItemId:[NSString stringWithFormat:@"%d",i] itemName:[NSString stringWithFormat:@"选项%d",i]];
        [self.dataSource addObject:item];
    }
    [self.tableView reloadData];
}
#pragma mark ************* lazy load *************
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 200) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        _tableView.rowHeight = 60.0;
    }
    return _tableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
@end
